require 'spec_helper'

describe "Admins::Users" do
  let(:valid_user) { FactoryGirl.attributes_for(:user) }
  let(:admin) { User.create(valid_user.merge({role: "admin"})) }
  let(:author) { User.create(valid_user.merge({role: "author"})) }

  describe "Author" do
    it "should not be able to edit role" do
      post_via_redirect user_session_path, 'user[email]' => author.email, 'user[password]' => valid_user[:password]
      put user_path(author.id), user: { first_name: "Alfred", role: "admin", current_password: valid_user[:password] }
      u = User.find(author.id)
      u.first_name.should eq("Alfred")
      u.role.should_not eq("admin")
    end
  end
end
