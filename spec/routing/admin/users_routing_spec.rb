require "rails_helper"

describe Admin::UsersController, type: :routing do
  let (:user) { FactoryGirl.create(:user) }

  describe "routing" do

    it "routes to #dashboard" do
      expect(get("/dashboard")).to route_to("admin/users#dashboard")
    end

    pending "routes to #new" do
      expect(get("/users/new")).to route_to("admin/users#new")
    end

    pending "routes to #show" do
      expect(get("/users/1")).to route_to("admin/users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/a/users/1/edit")).to route_to("admin/users#edit", :id => "1")
    end

    pending "routes to #create" do
      expect(post("/users")).to route_to("admin/users#create", :id => "1")
    end

    it "routes to #update" do
      expect(put("/a/users/1")).to route_to("admin/users#update", :id => "1")
    end

    # it "routes to #destroy" do
    #   expect(delete("/users/1")).to route_to("admin/users#destroy", :id => "1")
    # end

  end
end
