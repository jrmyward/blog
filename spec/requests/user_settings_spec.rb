require 'rails_helper'

describe "Admin::Users", type: :request do
  let(:valid_user) { attributes_for(:user) }
  let(:admin) { User.create(valid_user.merge({role: "admin"})) }
  let(:author) { User.create(valid_user.merge({role: "author"})) }

  describe "Author" do
    it "cannot be able to edit role" do
      post_via_redirect user_session_path, 'user[email]' => author.email, 'user[password]' => valid_user[:password]
      put admin_user_path(author.id), user: { first_name: "Alfred", role: "admin", current_password: valid_user[:password] }
      u = User.find(author.id)
      expect(u.first_name).to eq("Alfred")
      expect(u.role).to_not eq("admin")
    end
  end
end
