module PostsHelper

  def link_to_author(author)
    if author.gplus
      link_to "#{author.full_name}", "https://plus.google.com/#{author.gplus}?rel=author", target: "_blank"
    else
      "#{author.full_name}"
    end
  end

end
