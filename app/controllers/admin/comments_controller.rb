class Admin::CommentsController < AdminController
  before_action :set_admin_comment, only: [:show, :edit, :update, :destroy]

  # GET /admin/comments
  def index
    page      = Sanitize.clean(params[:page])
    @comments = Comment.paginate(:page => page, :per_page => 10).order("created_at desc")
  end

  # GET /admin/comments/1
  def show
  end

  # GET /admin/comments/new
  def new
    @comment = Comment.new
  end

  # GET /admin/comments/1/edit
  def edit
  end

  # POST /admin/comments
  def create
    @comment = Comment.new(admin_comment_params)

    if @comment.save
      redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/comments/1
  def update
    if @comment.update(admin_comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/comments/1
  def destroy
    @comment.destroy
    redirect_to admin_comments_url, notice: 'Comment was successfully destroyed.'
  end

  def destroy_multiple
    Comment.destroy(params[:comment_ids])
    redirect_to user_root_path, notice: "Successfully destroyed comments."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_comment_params
      params[:admin_comment]
    end
end
