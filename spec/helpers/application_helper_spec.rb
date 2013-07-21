require 'spec_helper'

describe ApplicationHelper do

  describe "is_active_link?" do
    it "should match the current link" do
      helper.stub(:current_page?).and_return(true)
      link_path = "/somepage"
      helper.is_active_link?(link_path).should be_true
    end

    it "should match a given Regular Expression" do
      helper.request.stub(:fullpath).and_return("/blog/some-article#comments")
      link_path = "/blog/some-article"
      helper.is_active_link?(link_path, /^\/blog/).should be_true
    end
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
