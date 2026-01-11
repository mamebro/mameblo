# frozen_string_literal: true

# Rack::Attack configuration for rate limiting and brute force protection
class Rack::Attack
  ### Configure Cache ###
  # Use Rails cache for storing rate limiting data
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Safelist ###
  # Allow all requests from localhost (development/testing)
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  ### Throttle Rules ###

  # General rate limit: 300 requests per 5 minutes per IP
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?('/assets')
  end

  # Brute force protection for login attempts
  # Limit: 5 login attempts per 20 seconds per IP
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/sessions' && req.post?
      req.ip
    end
  end

  # Additional tracking by username for login attempts
  # Limit: 10 login attempts per 10 minutes per username
  throttle('logins/username', limit: 10, period: 10.minutes) do |req|
    if req.path == '/sessions' && req.post?
      # Normalize username to prevent bypass via case manipulation
      req.params.dig('session', 'name')&.downcase&.strip
    end
  end

  # Rate limit for user registration
  # Limit: 3 registration attempts per hour per IP
  throttle('signup/ip', limit: 3, period: 1.hour) do |req|
    if req.path == '/brothers' && req.post?
      req.ip
    end
  end

  # Rate limit for password reset requests
  # Limit: 5 password reset requests per hour per IP
  throttle('password_reset/ip', limit: 5, period: 1.hour) do |req|
    if req.path == '/password_resets' && req.post?
      req.ip
    end
  end

  ### Blocklist Rules ###

  # Block IPs that have been flagged by fail2ban or similar tools
  # This reads from Rails cache with key pattern 'rack::attack:blocklist:ip:xxx'
  blocklist('block-bad-ips') do |req|
    Rack::Attack.cache.read("blocklist:ip:#{req.ip}")
  end

  ### Custom Response ###
  # Return 429 Too Many Requests with retry information
  self.throttled_responder = lambda do |request|
    match_data = request.env['rack.attack.match_data']
    now = match_data[:epoch_time]
    retry_after = (match_data[:period] - (now % match_data[:period])).to_i

    [
      429,
      {
        'Content-Type' => 'application/json',
        'Retry-After' => retry_after.to_s
      },
      [{ error: 'Rate limit exceeded. Please try again later.' }.to_json]
    ]
  end

  self.blocklisted_responder = lambda do |request|
    [
      403,
      { 'Content-Type' => 'application/json' },
      [{ error: 'Access denied.' }.to_json]
    ]
  end

  ### Logging ###
  # Log throttled and blocked requests for monitoring
  ActiveSupport::Notifications.subscribe('throttle.rack_attack') do |_name, _start, _finish, _id, payload|
    request = payload[:request]
    Rails.logger.warn(
      "[Rack::Attack] Throttled #{request.env['rack.attack.matched']} " \
      "from #{request.ip} on #{request.path}"
    )
  end

  ActiveSupport::Notifications.subscribe('blocklist.rack_attack') do |_name, _start, _finish, _id, payload|
    request = payload[:request]
    Rails.logger.warn(
      "[Rack::Attack] Blocked #{request.env['rack.attack.matched']} " \
      "from #{request.ip} on #{request.path}"
    )
  end
end
