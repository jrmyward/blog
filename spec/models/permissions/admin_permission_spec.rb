require "rails_helper"

describe Permissions::AdminPermission, type: :model do
  subject { Permissions.permission_for(build(:user, role: "admin")) }

  it "allows anything" do
    should authorize(:any, :thing)
    should allow_param(:any, :thing)
  end
end