require 'spec_helper'

describe "Admins::Users" do

  context "When admin edits profile" do
    let(:valid_user) { FactoryGirl.attributes_for(:user) }
    let(:admin) { User.create(valid_user.merge({role: "admin"})) }

    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: valid_user[:password]
      click_on 'submit_user_signin'
      click_on "#{admin.full_name}"
      click_on "Edit Profile"
    end

    describe "Failure" do
      it "should display an error message" do
        page.should have_content "First name"
        page.should have_content "Last name"
        page.should have_content "Email"
        page.should have_content "Role"
        page.should have_css "#user_gplus"
        page.should have_css "#user_twitter_handle"
        fill_in 'Email', with: ""
        click_on "Save Profile"
        page.should have_content "Oh Snap"
      end
    end

    describe "Success" do
      it "should display a success message and the updated information" do
        fill_in 'First name', with: "Steven"
        fill_in 'Current password', with: valid_user[:password]
        click_on "Save Profile"
        page.should_not have_content "Oh Snap"
        page.should have_content "Steven"
      end
    end

  end

  context "When author edits profile" do
    let(:valid_author) { FactoryGirl.attributes_for(:user) }
    let(:author) { User.create(valid_author.merge({role: "author"})) }

    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: author.email
      fill_in 'Password', with: valid_author[:password]
      click_on 'submit_user_signin'
      click_on "#{author.full_name}"
      click_on "Edit Profile"
    end

    describe "Failure" do
      it "should display an error message" do
        page.should have_content "First name"
        page.should have_content "Last name"
        page.should have_content "Email"
        page.should_not have_content "Role"
        page.should have_css "#user_gplus"
        page.should have_css "#user_twitter_handle"
        fill_in 'Email', with: ""
        click_on "Save Profile"
        page.should have_content "Oh Snap"
      end
    end

    describe "Success" do
      it "should display a success message and the updated information" do
        fill_in 'First name', with: "Steven"
        fill_in 'Current password', with: valid_author[:password]
        click_on "Save Profile"
        page.should_not have_content "Oh Snap"
        page.should have_content "Steven"
      end
    end

  end

end
