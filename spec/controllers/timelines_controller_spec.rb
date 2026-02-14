require 'spec_helper'

describe TimelinesController, type: :controller do
  let(:brother) { create(:brother) }
  let(:other_brother) { create(:brother) }

  describe "GET 'index'" do
    context "when not signed in" do
      it "returns http success" do
        get :index
        expect(response.response_code).to eq 200
      end

      it "assigns all entries" do
        entry = create(:entry, brother: brother)
        get :index
        expect(assigns(:entries)).to include(entry)
      end
    end

    context "when signed in" do
      before do
        sign_in_for_controller brother
        brother.follow!(other_brother)
      end

      let!(:followed_entry) { create(:entry, brother: other_brother) }
      let!(:unfollowed_brother) { create(:brother) }
      let!(:unfollowed_entry) { create(:entry, brother: unfollowed_brother) }

      it "returns http success" do
        get :index
        expect(response.response_code).to eq 200
      end

      it "assigns followed brother entries" do
        get :index
        expect(assigns(:entries)).to include(followed_entry)
      end

      it "excludes unfollowed brother entries" do
        get :index
        expect(assigns(:entries)).not_to include(unfollowed_entry)
      end
    end
  end

  describe "GET 'brothers'" do
    context "when not signed in" do
      it "redirects to root path" do
        get :brothers
        expect(response).to redirect_to(root_path)
      end
    end

    context "when signed in" do
      before { sign_in_for_controller brother }

      let!(:other_entry) { create(:entry, brother: other_brother) }
      let!(:own_entry) { create(:entry, brother: brother) }

      it "returns http success" do
        get :brothers
        expect(response.response_code).to eq 200
      end

      it "assigns other brothers' entries" do
        get :brothers
        expect(assigns(:entries)).to include(other_entry)
      end

      it "excludes own entries" do
        get :brothers
        expect(assigns(:entries)).not_to include(own_entry)
      end
    end
  end
end
