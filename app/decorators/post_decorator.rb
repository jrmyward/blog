class PostDecorator < Draper::Decorator
  decorates_association :author, with: UserDecorator
  delegate :full_name, to: :author, prefix: true
  delegate_all

  def link_to_author
    if object.author.gplus
      h.link_to author_full_name, "https://plus.google.com/#{author.gplus}?rel=author", target: "_blank"
    else
      author_full_name
    end
  end

  def published_date
    return "" if published_at.nil?
    published_at.strftime("%d %b %Y")
  end

  def published_date_en
    object.published_at.strftime("%B %d, %Y")
  end

  def published_status
    return "draft" if published_at.nil?
    published_at <= Time.now.utc ? "published" : "scheduled"
  end

  def status_badge
    h.content_tag(:span, class: "label label-#{status_label_css}") do
      published_status
    end
  end

  def status_label_css
    case published_status
    when "published"
      'success'
    when "scheduled"
      'info'
    else
      'default'
    end
  end

end
