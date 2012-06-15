require "spec_helper"

describe UsersController do
  describe "routing" do
    it "routes to #create" do
      post("/users").should route_to("users#create")
    end
  end
end
