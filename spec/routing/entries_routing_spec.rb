# -*- coding: utf-8 -*-
require "spec_helper"

describe EntriesController do
  describe "routing" do

    it "routes to #show" do
      get("/entries/1").should route_to("entries#show", :id => "1")
    end

    # エディット機能
    pending "routes to #edit" do
      get("/entries/1/edit").should route_to("entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/entries").should route_to("entries#create")
    end

    pending "routes to #update" do
      put("/entries/1").should route_to("entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/entries/1").should route_to("entries#destroy", :id => "1")
    end

  end
end
