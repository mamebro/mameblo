require 'spec_helper'

describe BeansController, type: :controller do
  describe "POST 'create'" do
    it "returns http success" do
      bro = create(:brother)
      sign_in_for_controller bro
      expect do
        post :create, xhr: true, params: { entry_id: 1 }
      end.to change(Bean, :count).by(1)
      expect(response.response_code).to eq 200
    end
  end
end
