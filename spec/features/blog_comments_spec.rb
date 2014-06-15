require 'spec_helper'

describe "Blog Comments" do
  let(:author) { create(:user, role: "author") }
  let(:post) { create(:post, :published_at => 2.weeks.ago, author_id: author.id, is_commentable: true) }

  context "Without JavaScript" do
    it "allows valid comments" do
      VCR.use_cassette "akismet/comment_ham" do
        visit post_path(post)
        within("#comments") do
          fill_in "Name", with: "Jon Test"
          fill_in "Email", with: "jd@example.com"
          fill_in "Comment", with: "Great Job! I learned a lot."
          click_on "Submit Comment"
        end
        expect(page).to have_content("Great Job! I learned a lot.")
      end
    end

    it "blocks spammy comments" do
      VCR.use_cassette "akismet/comment_spam" do
        visit post_path(post)
        within("#comments") do
          fill_in "Name", with: "Jon Test"
          fill_in "Email", with: "jd@example.com"
          fill_in "Site url", with: "eroticbeauties.net"
          fill_in "Comment", with: "Porn with Viagra is awesome!"
          click_on "Submit Comment"
        end
        expect(page).to have_content("Unfortunately this comment is considered spam by Akismet.")
      end
    end

    it "displays error with invalid comment" do
      visit post_path(post)
      click_on "Submit Comment"
      expect(page).to have_content("Oh Snap")
    end

    it "should work from the new action" do
      VCR.use_cassette "akismet/comment_ham" do
        visit new_post_comment_path(post)
        fill_in "Name", with: "Jon Test"
        fill_in "Email", with: "jd@example.com"
        fill_in "Comment", with: "Great Job! I learned a lot."
        click_on "Submit Comment"
        expect(page).to have_content("Great Job! I learned a lot.")
      end
    end
  end

  context "With JavaScript" do
    it "allows valid comments", :js do
      VCR.use_cassette "akismet/comment_ham" do
        visit post_path(post)
        within("#comment_form_prime") do
          fill_in "Name", with: "Jon Test"
          fill_in "Email", with: "jd@example.com"
          fill_in "Comment", with: "Great Job! I learned a lot."
          click_on "Submit Comment"
        end
        expect(page).to have_content("Great Job! I learned a lot.")
      end
    end

    # it "blocks spammy comments", :js do
    #   VCR.use_cassette "akismet/comment_spam" do
    #     visit post_path(post)
    #     within("#comment_form_prime") do
    #       fill_in "Name", with: "spam@example.com"
    #       fill_in "Email", with: "spam@example.com"
    #       fill_in "Site url", with: "eroticbeauties.net"
    #       fill_in "Comment", with: "Porn with Viagra is awesome!"
    #       click_on "Submit Comment"
    #     end
    #     expect(page).to have_content("Unfortunately This Comment Is Considered Spam By Akismet")
    #   end
    # end

    it "displays error with invalid comment", :js do
      visit post_path(post)
      click_on "Submit Comment"
      expect(page).to have_content("Oh Snap")
    end
  end

  context "Reply to Comment" do
    before(:each) do
      VCR.use_cassette "akismet/comment_ham" do
        @comment = create(:comment, commentable_id: post.id, commentable_type: "Post", name: "Peter", email: "parker@marvel.com")
      end
    end

    it "should not notify the commenter of a spammy reply" do
      VCR.use_cassette "akismet/comment_spam" do
        visit post_path(post)
        click_link "Reply"
        fill_in "Name", with: "Jon Test"
        fill_in "Email", with: "jd@example.com"
        fill_in "Site url", with: "eroticbeauties.net"
        fill_in "Comment", with: "Porn with Viagra is awesome!"
        click_on "Submit Comment"
        expect(email_count).to eq(1)
        expect(last_email.to).to include("jrmy.ward@gmail.com")
      end
    end

    it "should notify the commenter of a reply" do
      VCR.use_cassette "akismet/comment_ham" do
        visit post_path(post)
        click_link "Reply"
        fill_in "Name", with: "Jon Test"
        fill_in "Email", with: "jd@example.com"
        fill_in "Site url", with: "jontest.com"
        fill_in "Comment", with: "Great Job! I learned a lot."
        click_on "Submit Comment"
        expect(email_count).to eq(2)
        expect(last_email.to).to include(@comment.email)
      end
    end
  end
end