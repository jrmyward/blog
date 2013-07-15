require 'spec_helper'

describe User do
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  # it { should respond_to(:role) }

  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    context "role" do
      it "should allow valid roles" do
        %w(admin author member).each do |valid_role|
          user_with_valid_role = FactoryGirl.build(:user, :role => valid_role)
          user_with_valid_role.should be_valid
          user_with_valid_role.errors[:role].should == []
        end
      end

      it "should not allow false roles" do
        bad_role = FactoryGirl.build(:user, :role => "invalid")
        bad_role.should_not be_valid
        bad_role.errors[:role].should_not be_nil
      end
    end

  end
end
