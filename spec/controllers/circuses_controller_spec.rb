require 'spec_helper'

describe CircusesController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  pending "POST 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end
end
