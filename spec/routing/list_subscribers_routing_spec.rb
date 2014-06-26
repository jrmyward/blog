require "spec_helper"

describe ListSubscribersController do
  describe "routing" do

    it "routes to #new" do
      expect(get("/subscribers/new")).to route_to("list_subscribers#new")
    end

    it "routes to #create" do
      expect(post("/subscribers")).to route_to("list_subscribers#create")
    end

  end
end
