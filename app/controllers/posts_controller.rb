class PostsController < ApplicationController
  prepend_before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    page   = Sanitize.clean(params[:page])
    if params[:tag]
      unclean_tag = (params[:tag].include? "-") ? params[:tag].gsub!('-', ' ') : params[:tag]
      @tag   = Sanitize.clean(unclean_tag)
      @posts = Post.tagged_with(@tag).paginate(:page => page, :per_page => 10).order("published_at desc")
    else
      @posts = Post.paginate(:page => page, :per_page => 10).order("published_at desc")
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(params[:post])

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(params[:post])
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

end
