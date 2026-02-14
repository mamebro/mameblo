require 'spec_helper'

describe HashtagController, type: :controller do
  let(:brother) { create(:brother) }

  describe "GET 'show'" do
    context "when hashtag exists" do
      let(:hashtag) { Hashtag.create(name: 'テスト') }
      let!(:entry) { create(:entry, brother: brother, content: '#テスト') }

      before do
        EntryHasHashtag.create(hashtag: hashtag, entry: entry)
      end

      it "returns http success" do
        get :show, params: { id: 'テスト' }
        expect(response.response_code).to eq 200
      end

      it "assigns the hashtag name" do
        get :show, params: { id: 'テスト' }
        expect(assigns(:hashtag_name)).to eq('テスト')
      end

      it "assigns entries with the hashtag" do
        get :show, params: { id: 'テスト' }
        expect(assigns(:entries)).to include(entry)
      end
    end

    context "when hashtag does not exist" do
      it "redirects to root url" do
        get :show, params: { id: 'nonexistent' }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
