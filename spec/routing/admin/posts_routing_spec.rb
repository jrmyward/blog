require "spec_helper"

describe Admin::PostsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/a/blog/posts").to route_to("admin/posts#index")
    end

    it "routes to #new" do
      expect(:get => "/a/blog/posts/new").to route_to("admin/posts#new")
    end

    it "routes to #edit" do
      expect(:get => "/a/blog/posts/1/edit").to route_to("admin/posts#edit", id: "1")
    end

    it "routes to #create" do
      expect(:post => "/a/blog/posts").to route_to("admin/posts#create")
    end

    it "routes to #update" do
      expect(:put => "/a/blog/posts/1").to route_to("admin/posts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/a/blog/posts/1").to route_to("admin/posts#destroy", id: "1")
    end

  end
end
