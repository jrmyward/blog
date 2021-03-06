require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CommentsHelper. For example:
#
# describe CommentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe CommentsHelper, type: :helper do

  describe "button_for" do
    before(:each) do
      allow_any_instance_of(Comment).to receive(:spam?).and_return(false)
      @comment = create(:comment, commentable_id: 1, commentable_type: "Post", approved: true)
    end

    context "approved comment" do
      it "should render a reject button" do
        expect(helper.button_for(@comment)).to eq "<a class=\"btn btn-sm btn-danger\" data-confirm=\"Are you sure you want to mark the comment as spam?\" title=\"Reject comment.\" rel=\"nofollow\" data-method=\"put\" href=\"/a/comments/1/reject\"><i class='icon-thumbs-down icon-white'></i></a>"
      end
    end

    context "rejected comment" do
      it "should render an apporve button" do
        @comment.update_attribute(:approved, false)
        expect(helper.button_for(@comment)).to eq "<a class=\"btn btn-sm btn-default\" data-confirm=\"Are you sure you want to approve the comment?\" title=\"Approve comment.\" rel=\"nofollow\" data-method=\"put\" href=\"/a/comments/1/approve\"><i class='icon-thumbs-up'></i></a>"
      end
    end
  end

  describe "fix_url" do
    context "protocol provided" do
      it "should return the url" do
        url = "http://www.example.com"
        expect(helper.fix_url(url)).to eq url
      end
    end

    context "protocal not provided" do
      it "should append an http protocol" do
        url = "example.com"
        expect(helper.fix_url(url)).to eq "http://example.com"
      end
    end
  end

  describe "keep_spaces_at_beginning" do
    it "should keep leading spaces" do
      content = content_with_spaces
      expect(helper.keep_spaces_at_beginning(content)).to eq "This is the first line.\n\n&nbsp;&nbsp;&nbsp;&nbsp;The second line is lead by 4 spaces.\n\nThe last line has none."
    end
  end
end

def content_with_spaces
"This is the first line.

    The second line is lead by 4 spaces.

The last line has none."
end