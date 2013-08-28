require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #new" do
      get("/blog/posts/1/comments/new").should route_to("comments#new", post_id: "1")
    end

    it "routes to #create" do
      post("/blog/posts/1/comments").should route_to("comments#create", post_id: "1")
    end

  end
end
