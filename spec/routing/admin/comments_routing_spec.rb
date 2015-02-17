require "rails_helper"

describe Admin::CommentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/a/comments")).to route_to("admin/comments#index")
    end

    it "routes to #show" do
      expect(get("/a/comments/1")).to route_to("admin/comments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/a/comments/1/edit")).to route_to("admin/comments#edit", :id => "1")
    end

    it "routes to #update" do
      expect(put("/a/comments/1")).to route_to("admin/comments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/a/comments/1")).to route_to("admin/comments#destroy", :id => "1")
    end

    it "routes to #destroy_batch" do
      expect(delete("/a/comments/destroy-batch")).to route_to("admin/comments#destroy_batch")
    end

    it "routes to #approve" do
      expect(put("/a/comments/1/approve")).to route_to("admin/comments#approve", :id => "1")
    end

    it "routes to #reject" do
      expect(put("/a/comments/1/reject")).to route_to("admin/comments#reject", :id => "1")
    end

  end
end
