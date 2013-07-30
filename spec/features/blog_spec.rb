require 'spec_helper'

describe "Blog" do
  let(:valid_user) { FactoryGirl.attributes_for(:user) }
  let(:author) { User.create(valid_user.merge({role: "author"})) }
  let(:admin) { create(:user, role: "admin") }

  before(:each) {
    @post = FactoryGirl.create(:post, :published_at => 2.weeks.ago, author_id: admin.id)
  }

  it "displays a list of articles" do
    visit posts_path
    page.should have_content("#{@post.title.titleize}")
  end

  describe "Unauthorized" do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: author.email
      fill_in 'Password', with: valid_user[:password]
      click_on 'submit_user_signin'
    end

    it "should redirect with an error" do
      visit edit_post_path(@post.id)
      page.should have_content("You are not authorized.")
    end
  end

  describe "Admin" do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: valid_user[:password]
      click_on 'submit_user_signin'
    end

    it "can assign a post to any author" do
      visit new_post_path
      page.should have_content "Author"
    end
  end

  describe "Author" do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: author.email
      fill_in 'Password', with: valid_user[:password]
      click_on 'submit_user_signin'
    end

    it "only writes posts as themselves"do
      visit new_post_path
      page.should_not have_content "Author"
    end
  end

end
