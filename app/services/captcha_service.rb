# Service for validating Cap.js CAPTCHA tokens
# https://capjs.js.org
class CaptchaService
  class ValidationError < StandardError; end

  class << self
    def enabled?
      Rails.application.config.captcha.enabled
    end

    def site_key
      Rails.application.config.captcha.site_key
    end

    def server_url
      Rails.application.config.captcha.server_url
    end

    # Validates a CAPTCHA token from the client
    # Returns true if valid, false otherwise
    def validate(token)
      return true unless enabled?
      return false if token.blank?

      response = verify_token(token)
      response['success'] == true
    rescue Faraday::Error, JSON::ParserError => e
      Rails.logger.error("CAPTCHA validation error: #{e.message}")
      false
    end

    # Validates a CAPTCHA token from the client
    # Raises ValidationError if invalid
    def validate!(token)
      return true unless enabled?

      if token.blank?
        raise ValidationError, 'CAPTCHAトークンがありません'
      end

      response = verify_token(token)

      unless response['success'] == true
        raise ValidationError, 'CAPTCHA認証に失敗しました'
      end

      true
    rescue Faraday::Error => e
      Rails.logger.error("CAPTCHA validation error: #{e.message}")
      raise ValidationError, 'CAPTCHA認証サーバーに接続できません'
    rescue JSON::ParserError => e
      Rails.logger.error("CAPTCHA response parse error: #{e.message}")
      raise ValidationError, 'CAPTCHA認証レスポンスが不正です'
    end

    private

    def verify_token(token)
      conn = Faraday.new(url: server_url) do |f|
        f.request :json
        f.response :json
        f.options.timeout = 10
        f.options.open_timeout = 5
      end

      response = conn.post("/#{site_key}/siteverify") do |req|
        req.body = {
          secret: Rails.application.config.captcha.secret_key,
          response: token
        }
      end

      response.body
    end
  end
end
