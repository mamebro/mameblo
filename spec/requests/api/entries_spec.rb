require 'spec_helper'

describe 'entries api' do
  let(:password) { 'nejimakid0ri' }
  let(:kumiko) { FactoryGirl.create(:brother, name: 'kumiko', password: password, password_confirmation: password) }
  let(:entry) { FactoryGirl.create(:entry, brother: kumiko) }

  let(:token) do
    post '/api/signin', {name: kumiko.name, password: password}
    response.body
  end

  describe '/entries/:id' do
    context 'success' do
      it 'status 200' do
        get "/api/entries/#{entry.id}.json", {name: kumiko.name, auth_token: token}
        expect(response.status).to eq(200)
      end
    end

    context 'fail' do
      it 'status 401' do
        get "/api/entries/#{entry.id}.json", {name: kumiko.name}
        expect(response.status).to eq(401)
      end
    end
  end

  describe '/entiries/home' do
    context 'success' do
      let(:brothers) do
        brothers = []
        10.times do
          brothers << FactoryGirl.create(:brother)
        end
        brothers
      end

      let!(:followee) do
        brothers.each_with_object([]) do |brother, followee|
          if brother.id % 2 == 0
            kumiko.follow! brother
            followee << brother
          end
        end
      end

      def response_body
        JSON.parse(response.body)
      end

      before do
        brothers.each do |brother|
          FactoryGirl.create(:entry, brother: brother)
        end
      end

      it 'status 200' do
        get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
        expect(response.status).to eq(200)
      end

      it '自分がフォローしている人の投稿だけ取得する' do
        followee_ids = followee.map(&:id)
        get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
        response_body["entries"].each do |entry|
          expect(followee_ids).to include(entry["brother"]["id"])
        end
      end

      describe '最新の投稿を取得するURL' do
        let(:latest_url) { response_body["meta"]["_links"]["latest"] }

        it '拡張子はjsonである' do
          get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
          expect(latest_url).to match(/home\.json/)
        end
      end

      describe '過去の投稿を取得するURL' do
        let(:previous_url) { response_body["meta"]["_links"]["previous"] }

        it '拡張子はjsonである' do
          get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
          expect(previous_url).to match(/home\.json/)
        end
      end
    end

    context 'fail' do
      it 'status 401' do
        get "/api/entries/home.json", {name: kumiko.name}
        expect(response.status).to eq(401)
      end
    end
  end
end
