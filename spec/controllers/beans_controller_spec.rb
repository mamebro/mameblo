require 'spec_helper'

describe BeansController, type: :controller do
  describe "POST 'create'" do
    it "returns http success" do
      bro = FactoryGirl.create(:brother)
      sign_in bro
      expect do
        xhr :post, :create, entry_id: 1
      end.to change(Bean, :count).by(1)
      expect(response).to be_success
    end
  end
end
