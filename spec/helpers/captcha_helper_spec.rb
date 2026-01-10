require 'spec_helper'

describe CaptchaHelper, type: :helper do
  describe '#captcha_widget' do
    context 'when CAPTCHA is disabled' do
      before do
        allow(CaptchaService).to receive(:enabled?).and_return(false)
      end

      it 'returns nil' do
        expect(helper.captcha_widget).to be_nil
      end
    end

    context 'when CAPTCHA is enabled' do
      before do
        allow(CaptchaService).to receive(:enabled?).and_return(true)
        allow(CaptchaService).to receive(:server_url).and_return('http://localhost:3001')
        allow(CaptchaService).to receive(:site_key).and_return('test_site_key')
      end

      it 'renders a cap-widget element' do
        result = helper.captcha_widget
        expect(result).to have_css('cap-widget')
      end

      it 'includes data-cap-api-endpoint attribute' do
        result = helper.captcha_widget
        expect(result).to have_css('cap-widget[data-cap-api-endpoint="http://localhost:3001/test_site_key/"]')
      end
    end
  end

  describe '#captcha_token_field' do
    context 'when CAPTCHA is disabled' do
      before do
        allow(CaptchaService).to receive(:enabled?).and_return(false)
      end

      it 'returns nil' do
        expect(helper.captcha_token_field).to be_nil
      end
    end

    context 'when CAPTCHA is enabled' do
      before do
        allow(CaptchaService).to receive(:enabled?).and_return(true)
      end

      it 'renders a hidden field for captcha token' do
        result = helper.captcha_token_field
        expect(result).to have_css('input[type="hidden"][name="captcha_token"]', visible: false)
      end
    end
  end

  describe '#captcha_enabled?' do
    context 'when CAPTCHA is disabled' do
      before do
        allow(CaptchaService).to receive(:enabled?).and_return(false)
      end

      it 'returns false' do
        expect(helper.captcha_enabled?).to be false
      end
    end

    context 'when CAPTCHA is enabled' do
      before do
        allow(CaptchaService).to receive(:enabled?).and_return(true)
      end

      it 'returns true' do
        expect(helper.captcha_enabled?).to be true
      end
    end
  end
end
