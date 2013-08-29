require "spec_helper"

describe Admin::CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/comments").should route_to("admin/comments#index")
    end

    it "routes to #show" do
      get("/comments/1").should route_to("admin/comments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/comments/1/edit").should route_to("admin/comments#edit", :id => "1")
    end

    it "routes to #update" do
      put("/comments/1").should route_to("admin/comments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/comments/1").should route_to("admin/comments#destroy", :id => "1")
    end

    it "routes to #destroy_batch" do
      delete("/comments/destroy-batch").should route_to("admin/comments#destroy_batch")
    end

    it "routes to #approve" do
      put("/comments/1/approve").should route_to("admin/comments#approve", :id => "1")
    end

    it "routes to #reject" do
      put("/comments/1/reject").should route_to("admin/comments#reject", :id => "1")
    end

  end
end
