class PostsController < ApplicationController
  before_action :set_posts, only: [:index]
  before_action :set_post, only: [:show]
  before_action :set_list_subscriber, only: [:index, :show]
  before_action :set_tags, only: [:index, :show]

  # GET /posts
  def index
  end

  # GET /posts/1
  def show
    @commentable = @post
    @comment = Comment.new
  end

  private
  def set_list_subscriber
    @list_subscriber = ListSubscriber.new
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def set_posts
    page   = Sanitize.clean(params[:page])
    if params[:tag]
      set_tag
      @posts = Post.tagged_with(@tag).paginate(:page => page, :per_page => 10).order("published_at desc")
    else
      @posts = Post.paginate(:page => page, :per_page => 10).order("published_at desc")
    end
  end

  def set_tag
    unclean_tag = (params[:tag].include? "-") ? params[:tag].gsub!('-', ' ') : params[:tag]
    @tag   = Sanitize.clean(unclean_tag)
  end

  def set_tags
    @tags = Post.tag_counts_on(:tags)
  end

end








