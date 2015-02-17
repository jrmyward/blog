require 'rails_helper'

describe "Admin::Users", type: :feature do

  context "When admin edits profile" do
    let(:valid_user) { attributes_for(:user) }
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
        expect(page).to have_content "First name"
        expect(page).to have_content "Last name"
        expect(page).to have_content "Email"
        expect(page).to have_content "Role"
        expect(page).to have_css "#user_gplus"
        expect(page).to have_css "#user_twitter_handle"
        fill_in 'Email', with: ""
        click_on "Save Changes"
        expect(page).to have_content "Oh Snap"
      end
    end

    describe "Success" do
      it "should display a success message and the updated information" do
        fill_in 'First name', with: "Steven"
        fill_in 'Current password', with: valid_user[:password]
        click_on "Save Changes"
        expect(page).to_not have_content "Oh Snap"
        expect(page).to have_content "Steven"
      end
    end

  end

  context "When author edits profile" do
    let(:valid_author) { attributes_for(:user) }
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
        expect(page).to have_content "First name"
        expect(page).to have_content "Last name"
        expect(page).to have_content "Email"
        expect(page).to_not have_content "Role"
        expect(page).to have_css "#user_gplus"
        expect(page).to have_css "#user_twitter_handle"
        fill_in 'Email', with: ""
        click_on "Save Changes"
        expect(page).to have_content "Oh Snap"
      end
    end

    describe "Success" do
      it "should display a success message and the updated information" do
        fill_in 'First name', with: "Steven"
        fill_in 'Current password', with: valid_author[:password]
        click_on "Save Changes"
        expect(page).to_not have_content "Oh Snap"
        expect(page).to have_content "Steven"
      end
    end

  end

end
