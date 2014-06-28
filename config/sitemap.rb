# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://jrmyward.com"

SitemapGenerator::Sitemap.create do

  add root_path

  # Blog
  add posts_path
  Post.published do |post|
    add post_path(post), :lastmod => post.updated_at
  end
  Post.tag_counts.map { |t| t.name.parameterize }.each do |tag|
    add tag_path(tag)
  end

end
