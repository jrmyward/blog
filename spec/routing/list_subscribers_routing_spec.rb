require "rails_helper"

describe ListSubscribersController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(get("/subscribers/new")).to route_to("list_subscribers#new")
    end

    it "routes to #create" do
      expect(post("/subscribers")).to route_to("list_subscribers#create")
    end

    it "accepts a POST to confirm" do
      expect(post("/subscribers/confirm")).to route_to("list_subscribers#confirm")
    end

  end
end
