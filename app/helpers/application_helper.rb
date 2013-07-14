module ApplicationHelper
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
    url = url_for(url).sub(/\?.*/, '') # ignore GET params
    case condition
    when Regexp
      !request.fullpath.match(condition).blank?
    else
      current_page?(link_path)
    end
  end

  def nav_link(link_text, link_path, condition = nil)
    class_name = is_active_link?(link_path, condition) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end
end
