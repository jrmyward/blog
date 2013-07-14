require 'spec_helper'

describe ApplicationHelper do

  describe "is_active_link?" do

  end

  describe "nav_link" do
    it "should return an active link" do
      helper.stub(:is_active_link?).and_return(true)
      helper.nav_link("Active link", "/active-link").should == "<li class=\"active\"><a href=\"/active-link\">Active link</a></li>"
    end

    it "should return a non-active link" do
      helper.stub(:is_active_link?).and_return(false)
      helper.nav_link("Non-active link", "/non-active-link").should == "<li class=\"\"><a href=\"/non-active-link\">Non-active link</a></li>"
    end
  end

end
