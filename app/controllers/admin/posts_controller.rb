class Admin::PostsController < AdminController
  before_action :load_post, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  respond_to :html, :json

  # GET /a/blog/posts
  # GET /a/blog/posts.json
  def index
    load_posts
  end

  # GET /a/blog/posts/new
  def new
    @post = Post.new
  end

  # GET /a/blog/posts/1/edit
  def edit
  end

  # POST /a/blog/posts
  # POST /a/blog/posts.json
  def create
    @post = Post.new(params[:post])
    flash[:notice] = "Post was successfully created." if @post.save
    respond_with @post, location: admin_posts_path

  end

  # PATCH/PUT /a/blog/posts/1
  # PATCH/PUT /a/blog/posts/1.json
  def update
    flash[:notice] = 'Post was successfully updated.' if @post.update(params[:post])
    respond_with @post, location: admin_posts_path
  end

  # DELETE /a/blog/posts/1
  # DELETE /a/blog/posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def load_post
    @post ||= post_scope.friendly.find(params[:id]).decorate
  end

  def load_posts
    query         = params[:search]
    page          = params[:page] || 1
    sort_order    = [sort_column, sort_direction].join(" ")
    @posts ||= post_scope.text_search(query).paginate(page: page, per_page: 20).reorder(sort_order).decorate
  end

  def post_scope
    Post.all
  end

  def sort_column
    sort      = params[:sort]
    Post.column_names.include?(sort) ? sort : "published_at"
  end

  def sort_direction
    direction = params[:direction]
    %w[asc desc].include?(direction) ? direction : "desc"
  end
end
