require 'spec_helper'

describe Jinja::OsaisenController, type: :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response.response_code).to eq 200
    end
  end

end
