module CommentsHelper

  def append_new_comment(comment)
    render(comment) + content_tag(:div, "", :class => "nested_comments")
  end

  def button_for(comment)
    if comment.approved?
      link_to raw("<i class='mini-ico-thumbs-down mini-white'></i>"), reject_comment_path(comment), class: "btn btn-small btn-danger",
        data: { confirm: "Are you sure you want to mark the comment as spam?" }, method: :put, title: "Reject comment."
    else
      link_to raw("<i class='mini-ico-thumbs-up'></i>"), approve_comment_path(comment), class: "btn btn-small",
        data: { confirm: "Are you sure you want to approve the comment?" }, method: :put, title: "Approve comment."
    end
  end

  def fix_url(url)
    if url =~ /^https?\:\/\//
      url
    else
      "http://#{url}"
    end
  end

  def format_comment(comment)
    markdown_render(keep_spaces_at_beginning(h(comment.body)))
  end

  def keep_spaces_at_beginning(content)
    content.split("\n").map do |line|
      line.sub(/^ +/) do |spaces|
        '&nbsp;' * spaces.length
      end
    end.join("\n")
  end

  def marked_as_spam(comment)
    content_tag(:div, class: "alert alert-block alert-warn") do
      content_tag(:h4, "Unfortunately this comment is considered spam by Akismet. ", class: "alert-heading") +
      content_tag(:p, "It will show up once it has been approved by the administrator.")
    end
  end

  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      render(comment) + content_tag(:div, nested_comments(sub_comments), :class => "nested_comments")
    end.join.html_safe
  end

end
