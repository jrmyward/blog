require "spec_helper"

describe Admins::UsersController do
  let (:user) { FactoryGirl.create(:user) }

  describe "routing" do

    it "routes to #dashboard" do
      get("/dashboard").should route_to("admins/users#dashboard")
    end

    pending "routes to #new" do
      get("/users/new").should route_to("admins/users#new")
    end

    pending "routes to #show" do
      get("/users/1").should route_to("admins/users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/users/1/edit").should route_to("admins/users#edit", :id => "1")
    end

    pending "routes to #create" do
      post("/users").should route_to("admins/users#create", :id => "1")
    end

    it "routes to #update" do
      put("/users/1").should route_to("admins/users#update", :id => "1")
    end

    # it "routes to #destroy" do
    #   delete("/users/1").should route_to("admins/users#destroy", :id => "1")
    # end

  end
end
