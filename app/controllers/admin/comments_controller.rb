class Admin::CommentsController < AdminController
  before_action :set_comment, except: [:destroy_batch, :index]

  # GET /comments
  def index
    page      = Sanitize.clean(params[:page])
    @comments = Comment.paginate(:page => page, :per_page => 10).order("created_at desc")
  end

  # GET /comments/1
  def show
  end

  # GET /comments/1/edit
  def edit
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(params[:comment])
      redirect_to user_root_path, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # PATCH/PUT /comments/1/approve
  def approve
    @comment.mark_as_ham!
    redirect_to user_root_path, notice: "Comment has been approved."
  end

  # PATCH/PUT /comments/1/reject
  def reject
    @comment.mark_as_spam!
    redirect_to user_root_path, notice: "Comment has been rejected."
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to user_root_path, notice: 'Comment was successfully destroyed.'
  end

  def destroy_batch
    Comment.destroy(params[:comment_ids])
    redirect_to user_root_path, notice: "Successfully destroyed comments."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
end
