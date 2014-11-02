require 'spec_helper'

describe BrothersController, type: :controller do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "GET 'following'" do
    it "returns success" do
      brother = FactoryGirl.create(:brother)
      sign_in_for_controller brother
      get 'following', id: brother.id
      expect(response).to be_success
    end
  end

  describe "GET 'follower'" do
    it "returns success" do
      brother = FactoryGirl.create(:brother)
      sign_in_for_controller brother
      get 'followers', id: brother.id
      expect(response).to be_success
    end
  end
end
