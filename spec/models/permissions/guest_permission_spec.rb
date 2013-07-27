require "spec_helper"

describe Permissions::GuestPermission do
  subject { Permissions.permission_for(nil) }

  it "allows sessions" do
    should authorize("devise/sessions", :new)
    should authorize("devise/sessions", :create)
    should authorize("devise/sessions", :destroy)
  end

  it "allows posts" do
    should authorize(:posts, :index)
    should authorize(:posts, :show)
    should_not authorize(:posts, :create)
    should_not authorize(:posts, :edit)
    should_not authorize(:posts, :update)
    should_not authorize(:posts, :destroy)
  end

  it "allows users" do
    should_not authorize(:users, :new)
    should_not authorize(:users, :create)
    should_not authorize(:users, :edit)
    should_not authorize(:users, :update)
    should_not authorize(:users, :destroy)
  end
end
