require 'spec_helper'

describe BeansController do

  pending "POST 'create'" do
    it "returns http success" do
      expect do
        xhr :post, :create, entry_id: 1
      end.to change(bean, :count).by(1)
      response.should be_success
    end
  end
end
