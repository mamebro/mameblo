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
    end

    context "when signed in" do
      before do
        sign_in_for_controller brother
        brother.follow!(other_brother)
      end

      it "returns http success" do
        get :index
        expect(response.response_code).to eq 200
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

      it "returns http success" do
        get :brothers
        expect(response.response_code).to eq 200
      end
    end
  end
end
