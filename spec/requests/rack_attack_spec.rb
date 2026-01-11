# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Rack::Attack', type: :request do
  before do
    # Clear cache before each test to ensure clean state
    Rack::Attack.cache.store.clear
    # Enable Rack::Attack for testing
    Rack::Attack.enabled = true
  end

  after do
    Rack::Attack.cache.store.clear
  end

  describe 'login throttling' do
    let!(:brother) { create(:brother) }

    context 'when exceeding login rate limit per IP' do
      it 'blocks requests after 5 attempts in 20 seconds' do
        6.times do
          post '/sessions', params: { session: { name: 'test', password: 'wrong' } },
                            headers: { 'REMOTE_ADDR' => '1.2.3.4' }
        end

        expect(response.status).to eq(429)
        expect(response.headers['Retry-After']).to be_present
      end
    end

    context 'when exceeding login rate limit per username' do
      it 'blocks requests after 10 attempts in 10 minutes' do
        11.times do |i|
          post '/sessions', params: { session: { name: 'targetuser', password: 'wrong' } },
                            headers: { 'REMOTE_ADDR' => "1.2.3.#{i}" }
        end

        expect(response.status).to eq(429)
      end
    end
  end

  describe 'signup throttling' do
    context 'when exceeding signup rate limit' do
      it 'blocks requests after 3 attempts per hour' do
        4.times do
          post '/brothers', params: { brother: { name: 'test', password: 'password' } },
                            headers: { 'REMOTE_ADDR' => '1.2.3.4' }
        end

        expect(response.status).to eq(429)
      end
    end
  end

  describe 'password reset throttling' do
    context 'when exceeding password reset rate limit' do
      it 'blocks requests after 5 attempts per hour' do
        6.times do
          post '/password_resets', params: { email: 'test@example.com' },
                                   headers: { 'REMOTE_ADDR' => '1.2.3.4' }
        end

        expect(response.status).to eq(429)
      end
    end
  end

  describe 'general request throttling' do
    context 'when exceeding general rate limit' do
      it 'blocks requests after 300 per 5 minutes from same IP' do
        # Skip this test in normal runs as it requires many requests
        skip 'Takes too long for regular test runs'

        301.times do
          get '/', headers: { 'REMOTE_ADDR' => '1.2.3.4' }
        end

        expect(response.status).to eq(429)
      end
    end
  end

  describe 'safelist' do
    context 'when request is from localhost' do
      it 'allows requests from 127.0.0.1 without throttling' do
        10.times do
          post '/sessions', params: { session: { name: 'test', password: 'wrong' } },
                            headers: { 'REMOTE_ADDR' => '127.0.0.1' }
        end

        expect(response.status).not_to eq(429)
      end
    end
  end
end
