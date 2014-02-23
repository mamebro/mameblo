require 'spec_helper'

describe Api::SessionsController do
  let(:password) { 'nejimakid0ri' }
  let(:brother) { FactoryGirl.create(:brother, name: 'kumiko', password: password, password_confirmation: password) }

  describe 'create' do
    context 'success' do
      before do
        post :create, {name: brother.name, password: password}
      end

      it 'status 200' do
        expect(response.status).to eq(200)
      end

      it 'content-type text/plain' do
        expect(response.content_type).to eq('text/plain')
      end

      it 'トークンが取得できる' do
        expect(response.body).to match(/\A[0-9a-z]+\Z/)
      end

      context '複数回取得するとき' do
        it '同じトークンが得られる' do
          first_token = response.body
          post :create, {name: brother.name, password: password}
          expect(response.body).to eq first_token
        end
      end
    end

    context 'fail' do
      let(:wrong_password) { 'nejimakidori' }

      it 'status 401' do
        post :create, {name: brother.name, password: wrong_password}
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'delete' do
    let(:token) do
      post :create, {name: brother.name, password: password}
      response.body
    end

    context 'success' do
      it 'status 200' do

      end

      it 'api_authenticationsのレコードがひとつ減ること' do

      end
    end

    context 'fail' do
      let(:wrong_token) { 'wroooo0ng' }

      it 'status 401' do
        post :destroy, {name: brother.name, password: wrong_token}
        expect(response.status).to eq(401)
      end
    end
  end
end
