require 'spec_helper'

describe PasswordResetsController, type: :controller do

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response.response_code).to eq 200
    end
  end

end
