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

  describe "Comments" do
    it "allows valid comments" do
      visit post_path(@post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Comment", with: "Great Job! I learned a lot."
      click_on "Submit Comment"
      page.should have_content("Great Job! I learned a lot.")
    end

    it "blocks spammy comments" do
      visit post_path(@post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Site url", with: "eroticbeauties.net"
      fill_in "Comment", with: "Porn with Viagra is awesome!"
      click_on "Submit Comment"
      page.should have_content("Unfortunately this comment is considered spam by Akismet.")
    end

    it "displays error with invalid comment" do
      visit post_path(@post)
      click_on "Submit Comment"
      page.should have_content("Oh Snap")
    end
  end

  describe "Tags" do
    before(:each) do
      @post.update_attribute(:tag_list, 'test, Press Release')
    end

    ['test', 'press-release'].each do |tagname|
      it "filters articles by tag name" do
        visit "/blog/tags/#{tagname}"
        page.should have_content("#{@post.title.titleize}")
      end
    end
  end

end
