require 'spec_helper'

describe 'entries api' do
  let(:password) { 'nejimakid0ri' }
  let(:brother) { FactoryGirl.create(:brother, name: 'kumiko', password: password, password_confirmation: password) }
  let(:entry) { FactoryGirl.create(:entry, brother: brother) }

  let(:token) do
    post '/api/signin', {name: brother.name, password: password}
    response.body
  end

  describe '/entries/:id' do
    context 'success' do
      it 'status 200' do
        get "/api/entries/#{entry.id}.json", {name: brother.name, auth_token: token}
        expect(response.status).to eq(200)
      end
    end

    context 'fail' do
      it 'status 401' do
        get "/api/entries/#{entry.id}.json", {name: brother.name}
        expect(response.status).to eq(401)
      end
    end
  end

  describe '/entiries/home' do
    context 'success' do
      it 'status 200' do
        get "/api/entries/home.json", {name: brother.name, auth_token: token}
        expect(response.status).to eq(200)
      end
    end

    context 'fail' do
      it 'status 401' do
        get "/api/entries/home.json", {name: brother.name, auth_token: token}
        expect(response.status).to eq(401)
      end
    end
  end
end
