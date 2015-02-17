require "rails_helper"

describe CommentsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(get("/blog/posts/1/comments/new")).to route_to("comments#new", post_id: "1")
    end

    it "routes to #create" do
      expect(post("/blog/posts/1/comments")).to route_to("comments#create", post_id: "1")
    end

  end
end
