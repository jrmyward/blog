require "spec_helper"

describe Admins::UsersController do
  let (:user) { FactoryGirl.create(:user) }

  describe "routing" do

    it "routes to #dashboard" do
      get("/dashboard").should route_to("admins/users#dashboard")
    end

    pending "routes to #new" do
      get("/admins/users/new").should route_to("admins/users#new")
    end

    pending "routes to #show" do
      get("/settings/profile/1").should route_to("admins/users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/settings/profile").should route_to("admins/users#edit")
    end

    pending "routes to #create" do
      post("/admins/users").should route_to("admins/users#create")
    end

    it "routes to #update" do
      put("/settings/profile").should route_to("admins/users#update")
    end

    # it "routes to #destroy" do
    #   delete("/admins/users/1").should route_to("admins/users#destroy", :id => "1")
    # end

  end
end
