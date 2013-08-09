module PostsHelper

  def link_to_author(author)
    if author.gplus
      link_to "#{author.full_name}", "https://plus.google.com/#{author.gplus}?rel=author", target: "_blank"
    else
      "#{author.full_name}"
    end
  end

  def marked_as_spam(comment)
    content_tag(:div, class: "alert alert-block alert-warn") do
      content_tag(:h4, "Unfortunately this comment is considered spam by Akismet. ", class: "alert-heading") +
      content_tag(:p, "It will show up once it has been approved by the administrator.")
    end
  end

end
