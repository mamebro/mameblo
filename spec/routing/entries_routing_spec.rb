require "spec_helper"

describe EntriesController do
  describe "routing" do

    it "routes to #show" do
      {get: "/entries/1"}.should
      route_to(controller: "entries", action: "show", id: "1")
    end

    it "routes to #edit" do
      {get: "/entries/1/edit"}.should
      route_to(controller: "entries", action: "edit", id: "1")
    end

    it "routes to #create" do
      {post: "/entries"}.should
      route_to(controller: "entries", action: "create")
    end

    it "routes to #update" do
      {put: "/entries/1"}.should
      route_to(controller: "entries", action: "update", id: "1")
    end

    it "routes to #destroy" do
      {delete: "/entries/1"}.should
      route_to(controller: "entries", action: "destroy", id: "1")
    end

  end
end
