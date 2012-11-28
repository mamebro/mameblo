require "spec_helper"

describe BrothersController do
  describe "routing" do
    it "routes to #create" do
      {post: "/brohters"}.should
      route_to(controller: "brothers", action: "create")
    end
  end
end
