require "spec_helper"

describe Permissions::GuestPermission do
  subject { Permissions.permission_for(nil) }

  it "allows sessions" do
    should authorize(:sessions, :new)
    should authorize(:sessions, :create)
    should authorize(:sessions, :destroy)
  end

  it "allows users" do
    should_not authorize(:users, :new)
    should_not authorize(:users, :create)
    should_not authorize(:users, :edit)
    should_not authorize(:users, :update)
    should_not authorize(:users, :destroy)
  end
end
