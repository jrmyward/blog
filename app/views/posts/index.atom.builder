atom_feed do |feed|
  feed.title "Superhero Articles"
  feed.updated @posts.maximum(:updated_at)

  @posts.each do |post|
    feed.entry post, published: post.published_at do |entry|
      entry.title post.title
      entry.content post.abstract
      entry.author do |author|
        author.name post.author.full_name
      end
    end
  end
end