require 'spec_helper'

describe Api::SessionsController do
  let(:password) { 'nejimakid0ri' }
  let(:brother) { FactoryGirl.create(:brother, name: 'kumiko', password: password, password_confirmation: password) }

  describe 'create' do
    context 'success' do
      it 'status 200' do
        post :create, {name: brother.name, password: password}
        expect(response.status).to eq(200)
      end
    end

    context 'fail' do
      it 'status 401' do

      end
    end
  end

  describe 'delete' do
    before do
      # 事前にサインインしてトークンを取得しておく
    end

    context 'success' do
      it 'status 200' do

      end
    end

    context 'fail' do
      it 'status 401' do

      end
    end
  end

end
