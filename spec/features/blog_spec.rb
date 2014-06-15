require 'spec_helper'

describe "Blog" do
  let(:valid_user) { attributes_for(:user) }
  let(:author) { User.create(valid_user.merge({role: "author"})) }
  let(:admin) { create(:user, role: "admin") }

  before(:each) {
    @post = create(:post, :published_at => 2.weeks.ago, author_id: admin.id)
  }

  it "displays a list of articles" do
    visit posts_path
    expect(page).to have_content("#{@post.title.titleize}")
  end

  describe "Unauthorized" do
    before(:each) do
      visit new_user_session_path
      fill_in 'Email', with: author.email
      fill_in 'Password', with: valid_user[:password]
      click_on 'submit_user_signin'
    end

    it "should redirect with an error" do
      visit edit_admin_post_path(@post.id)
      expect(page).to have_content("You are not authorized.")
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
      visit new_admin_post_path
      expect(page).to have_content "Author"
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
      visit new_admin_post_path
      expect(page).to_not have_content "Author"
    end
  end

  describe "Tags" do
    before(:each) do
      @post.update_attribute(:tag_list, 'test, Press Release')
    end

    ['test', 'press-release'].each do |tagname|
      it "filters articles by tag name" do
        visit "/blog/tags/#{tagname}"
        expect(page).to have_content("#{@post.title.titleize}")
      end
    end
  end

end
