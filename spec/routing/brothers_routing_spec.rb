require "spec_helper"

describe BrothersController do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/brothers").to route_to(controller: "brothers", action: "create")
    end
  end
end
