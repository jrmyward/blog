require 'spec_helper'

describe "Blog" do
  let(:valid_user) { FactoryGirl.attributes_for(:user) }
  let(:user) { User.create(valid_user.merge({role: "author"})) }
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
      fill_in 'Email', with: user.email
      fill_in 'Password', with: valid_user[:password]
      click_on 'submit_user_signin'
    end

    it "should redirect with an error" do
      visit edit_post_path(@post.id)
      page.should have_content("You are ot authorized.")
    end
  end
end
