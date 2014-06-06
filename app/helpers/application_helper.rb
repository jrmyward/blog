module ApplicationHelper

  # Based on https://gist.github.com/1205828, in turn based on https://gist.github.com/1182136
  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def gravatar_url(user, size = 26)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
  end

  # Returns true or false based on the provided path and condition
  #
  # @param link_path [String] url of link to check
  # @param condition [Boolean, String] condition used to check link_path
  #   Possible condition values are:
  #     @option condition [Regex] regular expression
  #
  # @example
  #   is_active_link?('/root', /^\/root/)
  #
  # @return [Boolean]
  def is_active_link?(link_path, condition = nil)
    case condition
    when Regexp
      !request.fullpath.match(condition).blank?
    else
      current_page?(link_path)
    end
  end

  def markdown
    renderer = HTMLwithPygments.new(hard_wrap: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    @markdown ||= Redcarpet::Markdown.new(renderer, options)
  end

  def markdown_render(text)
    markdown.render(text).html_safe
  end

  def nav_link(link_text, link_path, condition = nil)
    class_name = is_active_link?(link_path, condition) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def page_navigation_links(pages)
     will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end
end
