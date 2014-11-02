require 'spec_helper'

describe 'Entries api', type: :request do
  let(:password) { 'nejimakid0ri' }
  let(:kumiko) { FactoryGirl.create(:brother, name: 'kumiko', password: password, password_confirmation: password) }
  let(:entry) { FactoryGirl.create(:entry, brother: kumiko) }

  let(:token) do
    post '/api/signin', {name: kumiko.name, password: password}
    response.body
  end

  describe 'GET /entries/:id.json' do
    context 'success' do
      it 'status 200' do
        get "/api/entries/#{entry.id}.json", {name: kumiko.name, auth_token: token}
        expect(response.status).to eq(200)
      end

      it '投稿を取得する' do
        get "/api/entries/#{entry.id}.json", {name: kumiko.name, auth_token: token}
        expect(response.body).to match(/#{entry.title}/)
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
          5.times do
            FactoryGirl.create(:entry, brother: brother)
          end
        end
      end

      it 'status 200' do
        get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
        expect(response.status).to eq(200)
      end

      pending '自分がフォローしている人(フォロイー)の投稿を取得する' do
        followee_ids = followee.map(&:id)
        get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
        response_body["entries"].each do |entry|
          expect(followee_ids).to include(entry["brother"]["id"])
        end
      end

      pending '件数' do
        it 'デフォルト20件' do
          get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
          expect(response_body["entries"].size).to eq 20
        end

        it '指定した件数' do
          get "/api/entries/home.json", {name: kumiko.name, auth_token: token, count: 10}
          expect(response_body["entries"].size).to eq 10
        end
      end

      pending '最新の投稿を取得するURL' do
        let(:latest_url) { response_body["meta"]["_links"]["latest"] }
        let(:latest_entry) { response_body["entries"].first }

        before do
          get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
        end

        it '拡張子はjsonである' do
          expect(latest_url).to match(/home\.json/)
        end

        it 'since_idが含まれている' do
          expect(latest_url).to match(/since_id\=#{latest_entry["id"]}/)
        end
      end

      pending '過去の投稿を取得するURL' do
        let(:previous_url) { response_body["meta"]["_links"]["previous"] }
        let(:oldest_entry) { response_body["entries"].last }

        before do
          get "/api/entries/home.json", {name: kumiko.name, auth_token: token}
        end

        it '拡張子はjsonである' do
          expect(previous_url).to match(/home\.json/)
        end

        it 'max_idが含まれている' do
          expect(previous_url).to match(/max_id\=#{oldest_entry["id"]-1}/)
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
