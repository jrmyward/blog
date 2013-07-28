module ApplicationHelper

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
    renderer    = Redcarpet::Render::HTML.new(:hard_wrap => true)
    extensions  = {:autolink => true, :no_intra_emphasis => true}
    @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
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
end
