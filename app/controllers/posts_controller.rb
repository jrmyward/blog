class PostsController < ApplicationController
  before_action :set_tags, only: [:index, :show]

  # GET /blog/posts
  def index
    load_posts
  end

  # GET /blog/posts/1
  def show
    load_post
    @commentable = @post
    @comment = Comment.new
  end

  private

  def load_post
    @post = Post.friendly.find(params[:id]).decorate
  end

  def load_posts
    page = params[:page] || 1
    if params[:tag]
      set_tag
      posts = Post.tagged_with(@tag).paginate(page: page, per_page: 10).published.order("published_at desc")
    else
      posts = Post.paginate(page: page, per_page: 10).published.order("published_at desc")
    end
    @posts = PostDecorator.decorate_collection(posts)
  end

  def set_tag
    unclean_tag = (params[:tag].include? "-") ? params[:tag].gsub!('-', ' ') : params[:tag]
    @tag   = unclean_tag
  end

  def set_tags
    @tags = Post.tag_counts_on(:tags)
  end

end
