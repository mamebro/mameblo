require "spec_helper"

describe BrothersController do
  describe "routing" do
    it "routes to #create" do
      post("/brothers").should route_to("brothers#create")
    end
  end
end
