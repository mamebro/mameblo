# Cap.js CAPTCHA configuration
# https://capjs.js.org

Rails.application.config.captcha = ActiveSupport::OrderedOptions.new

# Cap.js standalone server URL (e.g., "http://localhost:3001")
Rails.application.config.captcha.server_url = ENV.fetch('CAPTCHA_SERVER_URL', nil)

# Site key for the CAPTCHA widget
Rails.application.config.captcha.site_key = ENV.fetch('CAPTCHA_SITE_KEY', nil)

# Secret key for server-side validation
Rails.application.config.captcha.secret_key = ENV.fetch('CAPTCHA_SECRET_KEY', nil)

# Enable/disable CAPTCHA (useful for development/testing)
Rails.application.config.captcha.enabled = ENV.fetch('CAPTCHA_ENABLED', 'false') == 'true'
