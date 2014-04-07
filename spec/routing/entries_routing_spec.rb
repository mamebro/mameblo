require "spec_helper"

describe EntriesController do
  describe "routing" do

    it "routes to #show" do
      expect({get: "/entries/1"}).to route_to(controller: "entries", action: "show", id: "1")
    end

    it "routes to #edit" do
      expect({get: "/entries/1/edit"}).to route_to(controller: "entries", action: "edit", id: "1")
    end

    it "routes to #create" do
      expect({post: "/entries"}).to route_to(controller: "entries", action: "create")
    end

    it "routes to #update" do
      expect({put: "/entries/1"}).to route_to(controller: "entries", action: "update", id: "1")
    end

    it "routes to #destroy" do
      expect({delete: "/entries/1"}).to route_to(controller: "entries", action: "destroy", id: "1")
    end

  end
end
