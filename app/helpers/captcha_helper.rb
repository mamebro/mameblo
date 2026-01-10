# Helper methods for Cap.js CAPTCHA integration
module CaptchaHelper
  # Renders the Cap.js CAPTCHA widget
  def captcha_widget(options = {})
    return unless CaptchaService.enabled?

    content_tag(:div, nil, {
      id: options[:id] || 'cap-widget',
      class: "cap-widget #{options[:class]}".strip,
      data: {
        cap_widget: true,
        cap_api_endpoint: "#{CaptchaService.server_url}/#{CaptchaService.site_key}"
      }
    })
  end

  # Renders hidden field for CAPTCHA token
  def captcha_token_field(form_id = nil)
    return unless CaptchaService.enabled?

    hidden_field_tag('captcha_token', '', id: 'captcha-token', data: { cap_token_field: true })
  end

  # Check if CAPTCHA is enabled
  def captcha_enabled?
    CaptchaService.enabled?
  end
end
