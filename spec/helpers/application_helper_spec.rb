require 'spec_helper'

describe ApplicationHelper do

  describe "admin_link_to" do
    it "returns an admin formatted link" do
      admin_link = helper.admin_link_to("Zoom", "/example-page", "icon-zoom-in")
      expect(admin_link).to eq("<li class=\"\"><a class=\"\" href=\"/example-page\"><i class='icon-zoom-in'></i><span class=\"hidden-sm text\">Zoom</span></a></li>")
    end
  end

  describe "admin_link_to_dropdown" do
    it "returns a bootstrapped formatted dropdown link" do
      admin_link_dropdown = helper.admin_link_to_dropdown("Zoom", "icon-zoom-in")
      expect(admin_link_dropdown).to eq("<a class=\"dropmenu\" href=\"#\"><i class='icon-zoom-in'></i><span class=\"hidden-sm text\">Zoom</span><span class=\"chevron closed\" /></a>")
    end
  end

  describe "button_link_to" do
    it "returns a bootstrapped formatted link button" do
      link_button = helper.button_link_to("/example-page", "icon-zoom-in", "btn-default")
      expect(link_button).to eq("<a class=\"btn btn-default\" href=\"/example-page\"><i class=\"icon-zoom-in\"></i></a>")
    end
  end

  describe "button_link_to_destroy" do
    it "returns a bootstrapped formatted destroy link button" do
      destroy_link_button = helper.button_link_to_destroy("/destory")
      expect(destroy_link_button).to eq("<a class=\"btn btn-danger\" data-confirm=\"Are you sure?\" data-method=\"delete\" href=\"/destory\" rel=\"nofollow\"><i class=\"icon-trash\"></i></a>")
    end
  end

  describe "is_active_link?" do
    it "should match the current link" do
      link_path = "/somepage"
      allow(helper.request).to receive(:path).and_return(link_path)
      expect(helper.is_active_link?(link_path)).to be true
    end

    it "should match a given Regular Expression" do
      allow(helper.request).to receive(:fullpath).and_return("/blog/some-article#comments")
      link_path = "/blog/some-article"
      expect(helper.is_active_link?(link_path, /^\/blog/)).to be true
    end
  end

  describe "link_to_minimize" do
    it "returns a formatted minimize link" do
      expect(helper.link_to_minimize).to eq("<a class=\"btn-minimize\" href=\"#\"><i class='icon-chevron-up'></i></a>")
    end
  end

  describe "link_to_tags_inline" do
    it "should return comma seperated tag links" do
      tag_list = ["bar", "foo baz"]
      expect(helper.link_to_tags_inline(tag_list)).to eq "<a href=\"/blog/tags/bar\">bar</a>, <a href=\"/blog/tags/foo-baz\">foo baz</a>"
    end
  end

  describe "list_group_link" do
    it "should return an active link" do
      allow(helper).to receive(:is_active_link?).and_return(true)
      expect(helper.list_group_link("Active link", "/active-link")).to eq "<a class=\"list-group-item active\" href=\"/active-link\">Active link</a>"
    end

    it "should return a non-active link" do
      allow(helper).to receive(:is_active_link?).and_return(false)
      expect(helper.list_group_link("Non-active link", "/non-active-link")).to eq "<a class=\"list-group-item \" href=\"/non-active-link\">Non-active link</a>"
    end
  end

  describe "markdown_render" do
    it "should convert markdown formatted text to html" do
      text = "# This should be an H1"
      expect(helper.markdown_render(text)).to eq "<h1>This should be an H1</h1>\n"
    end
  end

  describe "nav_link" do
    it "should return an active link" do
      allow(helper).to receive(:is_active_link?).and_return(true)
      expect(helper.nav_link("Active link", "/active-link")).to eq "<li class=\"active\"><a href=\"/active-link\">Active link</a></li>"
    end

    it "should return a non-active link" do
      allow(helper).to receive(:is_active_link?).and_return(false)
      expect(helper.nav_link("Non-active link", "/non-active-link")).to eq "<li class=\"\"><a href=\"/non-active-link\">Non-active link</a></li>"
    end
  end

end
