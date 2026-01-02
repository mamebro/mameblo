require 'spec_helper'

describe EntriesController, type: :controller do
  let(:brother) { create(:brother) }
  let(:other_brother) { create(:brother) }
  let(:entry) { create(:entry, brother: brother) }

  describe "GET 'show'" do
    it "returns http success" do
      get :show, params: { id: entry.id }
      expect(response.response_code).to eq 200
    end

    it "responds to JSON format" do
      get :show, params: { id: entry.id, format: :json }
      expect(response.response_code).to eq 200
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, params: { id: entry.id }
      expect(response.response_code).to eq 200
    end
  end

  describe "POST 'create'" do
    context "when not signed in" do
      it "redirects to signin page" do
        post :create, params: { entry: { title: 'Test', content: 'Content' } }
        expect(response).to redirect_to(signin_path)
      end
    end

    context "when signed in" do
      before { sign_in_for_controller brother }

      context "with valid params" do
        it "creates a new entry" do
          expect {
            post :create, params: { entry: { title: 'Test Title', content: 'Test Content' } }
          }.to change(Entry, :count).by(1)
        end

        it "redirects to brother page" do
          post :create, params: { entry: { title: 'Test Title', content: 'Test Content' } }
          expect(response).to redirect_to(brother)
        end

        it "sets success flash message" do
          post :create, params: { entry: { title: 'Test Title', content: 'Test Content' } }
          expect(flash[:success]).to eq "!!! ぶろぐ投稿できたね !!!"
        end
      end

      context "with hashtags in content" do
        it "creates hashtags" do
          expect {
            post :create, params: { entry: { title: 'Test', content: '#テスト #ハッシュタグ' } }
          }.to change(Hashtag, :count).by(2)
        end

        it "creates entry_has_hashtag associations" do
          expect {
            post :create, params: { entry: { title: 'Test', content: '#テスト' } }
          }.to change(EntryHasHashtag, :count).by(1)
        end

        it "uses existing hashtag if already exists" do
          Hashtag.create(name: 'テスト')
          expect {
            post :create, params: { entry: { title: 'Test', content: '#テスト' } }
          }.not_to change(Hashtag, :count)
        end
      end

      context "with invalid params" do
        it "does not create a new entry" do
          expect {
            post :create, params: { entry: { title: '', content: '' } }
          }.not_to change(Entry, :count)
        end

        it "redirects to brother page with error" do
          post :create, params: { entry: { title: '', content: '' } }
          expect(response).to redirect_to(brother)
          expect(flash[:error]).to eq "!!! ぶろぐ投稿できませんでした !!!"
        end
      end
    end
  end

  describe "PATCH 'update'" do
    # NOTE: update action does not have signed_in_brother check
    # This should be fixed in a separate issue

    context "when signed in as wrong brother" do
      before { sign_in_for_controller other_brother }

      it "redirects to root path" do
        patch :update, params: { id: entry.id, entry: { title: 'Updated' } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when signed in as correct brother" do
      before { sign_in_for_controller brother }

      context "with valid params" do
        it "updates the entry" do
          patch :update, params: { id: entry.id, entry: { title: 'Updated Title', content: 'Updated Content' } }
          entry.reload
          expect(entry.title).to eq 'Updated Title'
          expect(entry.content).to eq 'Updated Content'
        end

        it "redirects to brother page" do
          patch :update, params: { id: entry.id, entry: { title: 'Updated', content: 'Content' } }
          expect(response).to redirect_to(brother)
        end

        it "sets notice flash message" do
          patch :update, params: { id: entry.id, entry: { title: 'Updated', content: 'Content' } }
          expect(flash[:notice]).to eq '!!! 編集完了したね !!!'
        end
      end

      context "with hashtags" do
        it "creates new hashtag on update" do
          expect {
            patch :update, params: { id: entry.id, entry: { title: entry.title, content: '#新しいタグ' } }
          }.to change(Hashtag, :count).by(1)
        end

        it "uses existing hashtag on update" do
          Hashtag.create(name: '既存タグ')
          expect {
            patch :update, params: { id: entry.id, entry: { title: entry.title, content: '#既存タグ' } }
          }.not_to change(Hashtag, :count)
        end
      end

      context "with invalid params" do
        it "does not update the entry" do
          original_title = entry.title
          patch :update, params: { id: entry.id, entry: { title: '', content: '' } }
          expect(entry.reload.title).to eq original_title
        end

        it "returns error response" do
          patch :update, params: { id: entry.id, entry: { title: '', content: '' } }
          expect(response.response_code).to eq 200  # renders edit template
        end
      end

      context "with JSON format" do
        it "returns no content on success" do
          patch :update, params: { id: entry.id, entry: { title: 'Updated', content: 'Content' }, format: :json }
          expect(response).to have_http_status(:no_content)
        end

        it "returns unprocessable entity on failure" do
          patch :update, params: { id: entry.id, entry: { title: '', content: '' }, format: :json }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    let!(:entry_to_delete) { create(:entry, brother: brother) }

    context "when not signed in" do
      it "redirects to signin page" do
        delete :destroy, params: { id: entry_to_delete.id }
        expect(response).to redirect_to(signin_path)
      end
    end

    context "when signed in as wrong brother" do
      before { sign_in_for_controller other_brother }

      it "redirects to root path" do
        delete :destroy, params: { id: entry_to_delete.id }
        expect(response).to redirect_to(root_path)
      end

      it "does not delete the entry" do
        expect {
          delete :destroy, params: { id: entry_to_delete.id }
        }.not_to change(Entry, :count)
      end
    end

    context "when signed in as correct brother" do
      before { sign_in_for_controller brother }

      it "deletes the entry" do
        expect {
          delete :destroy, params: { id: entry_to_delete.id }
        }.to change(Entry, :count).by(-1)
      end

      it "redirects to root path" do
        delete :destroy, params: { id: entry_to_delete.id }
        expect(response).to redirect_to(root_path)
      end

      it "sets success flash message" do
        delete :destroy, params: { id: entry_to_delete.id }
        expect(flash[:success]).to eq "!!! 日記を消したぜブラザー !!!"
      end
    end
  end
end
