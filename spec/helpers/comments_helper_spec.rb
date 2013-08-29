require 'spec_helper'

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
describe CommentsHelper do

  describe "button_for" do
    let(:comment) { create(:comment, commentable_id: 1, commentable_type: "Post", approved: true) }
    context "approved comment" do
      it "should render a reject button" do
        helper.button_for(comment).should == "<a class=\"btn btn-small btn-danger\" data-confirm=\"Are you sure you want to mark the comment as spam?\" data-method=\"put\" href=\"/comments/1/reject\" rel=\"nofollow\" title=\"Reject comment.\"><i class='mini-ico-thumbs-down mini-white'></i></a>"
      end
    end

    context "rejected comment" do
      it "should render an apporve button" do
        comment.update_attribute(:approved, false)
        helper.button_for(comment).should == "<a class=\"btn btn-small\" data-confirm=\"Are you sure you want to approve the comment?\" data-method=\"put\" href=\"/comments/1/approve\" rel=\"nofollow\" title=\"Approve comment.\"><i class='mini-ico-thumbs-up'></i></a>"
      end
    end
  end

  describe "fix_url" do
    context "protocol provided" do
      it "should return the url" do
        url = "http://www.example.com"
        helper.fix_url(url).should == url
      end
    end

    context "protocal not provided" do
      it "should append an http protocol" do
        url = "example.com"
        helper.fix_url(url).should == "http://example.com"
      end
    end
  end

  describe "keep_spaces_at_beginning" do
    it "should keep leading spaces" do
      content = content_with_spaces
      helper.keep_spaces_at_beginning(content).should == "This is the first line.\n\n&nbsp;&nbsp;&nbsp;&nbsp;The second line is lead by 4 spaces.\n\nThe last line has none."
    end
  end
end

def content_with_spaces
"This is the first line.

    The second line is lead by 4 spaces.

The last line has none."
end