require 'spec_helper'

describe "Admins::Users" do
  let(:valid_user) { FactoryGirl.attributes_for(:user) }
  let(:admin) { User.create(valid_user.merge({role: "admin"})) }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: valid_user[:password]
    click_on 'submit_user_signin'
  end

  describe "Edits Profile" do
    before(:each) do
      click_on "#{admin.full_name}"
      click_on "Edit Profile"
    end

    context "Failure" do
      it "should display an error message" do
        page.should have_content "First name"
        page.should have_content "Last name"
        page.should have_content "Email"
        fill_in 'Email', with: ""
        click_on "Save Profile"
        page.should have_content("Oh Snap")
      end
    end

    context "Success" do
      it "should display a success message and the updated information" do
        fill_in 'First name', with: "Steven"
        fill_in 'Current password', with: valid_user[:password]
        click_on "Save Profile"
        page.should_not have_content("Oh Snap")
        page.should have_content "Steven"
      end
    end
  end
end
