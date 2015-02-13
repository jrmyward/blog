atom_feed do |feed|
  feed.title "Wayward Traveler Posts"
  feed.updated Post.published.maximum(:published_at)

  @posts.each do |post|
    feed.entry post, published: post.published_at do |entry|
      entry.title post.title
      entry.content post.abstract
      entry.author do |author|
        author.name post.author_full_name
      end
    end
  end
end