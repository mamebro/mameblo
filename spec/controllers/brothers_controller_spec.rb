require 'spec_helper'

describe BrothersController, type: :controller do
  let(:brother) { create(:brother) }

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response.response_code).to eq 200
    end
  end

  describe "GET 'following'" do
    it "returns success" do
      sign_in_for_controller brother
      get 'following', params: { id: brother.id }
      expect(response.response_code).to eq 200
    end
  end

  describe "GET 'follower'" do
    it "returns success" do
      sign_in_for_controller brother
      get 'followers', params: { id: brother.id }
      expect(response.response_code).to eq 200
    end
  end
end
