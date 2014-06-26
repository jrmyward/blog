require "spec_helper"

describe Permissions::GuestPermission do
  subject { Permissions.permission_for(nil) }

  it "allows comments" do
    should authorize(:comments, :index)
    should authorize(:comments, :new)
    should authorize(:comments, :create)
    should_not authorize(:comments, :edit)
    should_not authorize(:comments, :update)
    should_not authorize(:comments, :destroy)
  end

  it "allows list subscribers" do
    should authorize("list_subscribers", :create)
    should authorize("list_subscribers", :confirm)
    should authorize("list_subscribers", :new)
    should_not authorize("list_subscribers", :show)
    should_not authorize("list_subscribers", :edit)
    should_not authorize("list_subscribers", :update)
    should_not authorize("list_subscribers", :destroy)
    should_not allow_param("list_subscriber", :sync)
  end

  it "allows posts" do
    should authorize(:posts, :index)
    should authorize(:posts, :show)
    should_not authorize(:posts, :create)
    should_not authorize(:posts, :edit)
    should_not authorize(:posts, :update)
    should_not authorize(:posts, :destroy)
  end

  it "allows sessions" do
    should authorize("devise/sessions", :new)
    should authorize("devise/sessions", :create)
    should authorize("devise/sessions", :destroy)
  end

  it "allows users" do
    should_not authorize(:users, :new)
    should_not authorize(:users, :create)
    should_not authorize(:users, :edit)
    should_not authorize(:users, :update)
    should_not authorize(:users, :destroy)
  end
end
