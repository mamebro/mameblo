require 'spec_helper'

describe CaptchaService do
  describe '.enabled?' do
    context 'when CAPTCHA is disabled (default)' do
      it 'returns false' do
        expect(CaptchaService.enabled?).to be false
      end
    end

    context 'when CAPTCHA is enabled' do
      before do
        allow(Rails.application.config.captcha).to receive(:enabled).and_return(true)
      end

      it 'returns true' do
        expect(CaptchaService.enabled?).to be true
      end
    end
  end

  describe '.validate' do
    context 'when CAPTCHA is disabled' do
      it 'returns true without making any requests' do
        expect(CaptchaService.validate(nil)).to be true
        expect(CaptchaService.validate('')).to be true
        expect(CaptchaService.validate('any_token')).to be true
      end
    end

    context 'when CAPTCHA is enabled' do
      let(:stubs) { Faraday::Adapter::Test::Stubs.new }
      let(:conn) do
        Faraday.new do |builder|
          builder.request :json
          builder.response :json
          builder.adapter :test, stubs
        end
      end

      before do
        allow(Rails.application.config.captcha).to receive(:enabled).and_return(true)
        allow(Rails.application.config.captcha).to receive(:server_url).and_return('http://localhost:3001')
        allow(Rails.application.config.captcha).to receive(:site_key).and_return('test_site_key')
        allow(Rails.application.config.captcha).to receive(:secret_key).and_return('test_secret_key')
        allow(Faraday).to receive(:new).and_return(conn)
      end

      after do
        stubs.verify_stubbed_calls
      end

      it 'returns false when token is blank' do
        expect(CaptchaService.validate(nil)).to be false
        expect(CaptchaService.validate('')).to be false
      end

      it 'returns true when verification succeeds' do
        stubs.post('/test_site_key/siteverify') do
          [200, { 'Content-Type' => 'application/json' }, { 'success' => true }.to_json]
        end

        expect(CaptchaService.validate('valid_token')).to be true
      end

      it 'returns false when verification fails' do
        stubs.post('/test_site_key/siteverify') do
          [200, { 'Content-Type' => 'application/json' }, { 'success' => false }.to_json]
        end

        expect(CaptchaService.validate('invalid_token')).to be false
      end

      it 'returns false when server returns an error' do
        stubs.post('/test_site_key/siteverify') do
          raise Faraday::Error, 'Connection failed'
        end

        expect(CaptchaService.validate('some_token')).to be false
      end
    end
  end

  describe '.validate!' do
    context 'when CAPTCHA is disabled' do
      it 'returns true without making any requests' do
        expect(CaptchaService.validate!(nil)).to be true
      end
    end

    context 'when CAPTCHA is enabled' do
      let(:stubs) { Faraday::Adapter::Test::Stubs.new }
      let(:conn) do
        Faraday.new do |builder|
          builder.request :json
          builder.response :json
          builder.adapter :test, stubs
        end
      end

      before do
        allow(Rails.application.config.captcha).to receive(:enabled).and_return(true)
        allow(Rails.application.config.captcha).to receive(:server_url).and_return('http://localhost:3001')
        allow(Rails.application.config.captcha).to receive(:site_key).and_return('test_site_key')
        allow(Rails.application.config.captcha).to receive(:secret_key).and_return('test_secret_key')
        allow(Faraday).to receive(:new).and_return(conn)
      end

      after do
        stubs.verify_stubbed_calls
      end

      it 'raises ValidationError when token is blank' do
        expect { CaptchaService.validate!(nil) }.to raise_error(CaptchaService::ValidationError)
        expect { CaptchaService.validate!('') }.to raise_error(CaptchaService::ValidationError)
      end

      it 'returns true when verification succeeds' do
        stubs.post('/test_site_key/siteverify') do
          [200, { 'Content-Type' => 'application/json' }, { 'success' => true }.to_json]
        end

        expect(CaptchaService.validate!('valid_token')).to be true
      end

      it 'raises ValidationError when verification fails' do
        stubs.post('/test_site_key/siteverify') do
          [200, { 'Content-Type' => 'application/json' }, { 'success' => false }.to_json]
        end

        expect { CaptchaService.validate!('invalid_token') }.to raise_error(CaptchaService::ValidationError)
      end
    end
  end
end
