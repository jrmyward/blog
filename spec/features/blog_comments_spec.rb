require 'spec_helper'

describe "Blog Comments" do
  let(:author) { create(:user, role: "author") }
  let(:post) { create(:post, :published_at => 2.weeks.ago, author_id: author.id, is_commentable: true) }

  context "Without JavaScript" do
    it "allows valid comments" do
      visit post_path(post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Comment", with: "Great Job! I learned a lot."
      click_on "Submit Comment"
      page.should have_content("Great Job! I learned a lot.")
    end

    it "blocks spammy comments" do
      visit post_path(post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Site url", with: "eroticbeauties.net"
      fill_in "Comment", with: "Porn with Viagra is awesome!"
      click_on "Submit Comment"
      page.should have_content("Unfortunately this comment is considered spam by Akismet.")
    end

    it "displays error with invalid comment" do
      visit post_path(post)
      click_on "Submit Comment"
      page.should have_content("Oh Snap")
    end

    it "should work from the new action" do
      visit new_post_comment_path(post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Comment", with: "Great Job! I learned a lot."
      click_on "Submit Comment"
      page.should have_content("Great Job! I learned a lot.")
    end
  end

  context "With JavaScript" do
    it "allows valid comments", :js do
      visit post_path(post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Comment", with: "Great Job! I learned a lot."
      click_on "Submit Comment"
      page.should have_content("Great Job! I learned a lot.")
    end

    it "blocks spammy comments", :js do
      visit post_path(post)
      fill_in "Name", with: "Jon Test"
      fill_in "Email", with: "jd@example.com"
      fill_in "Site url", with: "eroticbeauties.net"
      fill_in "Comment", with: "Porn with Viagra is awesome!"
      click_on "Submit Comment"
      page.should have_content("Unfortunately this comment is considered spam by Akismet.")
    end

    it "displays error with invalid comment", :js do
      visit post_path(post)
      click_on "Submit Comment"
      page.should have_content("Oh Snap")
    end
  end

  context "Reply to Comment" do
    pending "it notifies relevent commenters"
  end
end