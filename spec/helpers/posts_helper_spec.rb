require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe PostsHelper do

  describe "link_to_author" do
    before(:each) do
      @author = FactoryGirl.create(:user, role: "author")
    end

    describe "when they have a google plus page" do |variable|
      it "should link to an author's google plus page" do
        @author.update_attribute(:gplus, '12345')
        helper.link_to_author(@author).should == "<a href=\"https://plus.google.com/#{@author.gplus}?rel=author\" target=\"_blank\">#{@author.full_name}</a>"
      end
    end

    describe "when they don't have a google plus page" do
      it "should NOT link to an author's google plus page" do
        @author.update_attribute(:gplus, nil)
        helper.link_to_author(@author).should == "#{@author.full_name}"
      end
    end
  end

end