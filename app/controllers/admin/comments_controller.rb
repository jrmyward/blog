class Admin::CommentsController < AdminController
  before_action :load_comment, except: [:destroy_batch, :index]
  helper_method :sort_column, :sort_direction

  # GET /a/comments
  def index
    load_comments
  end

  # GET /a/comments/1/edit
  def edit
  end

  # PATCH/PUT /a/comments/1
  def update
    if @comment.update(params[:comment])
      redirect_to admin_comments_path, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # PATCH/PUT /a/comments/1/approve
  def approve
    @comment.mark_as_ham!
    redirect_to admin_comments_path, notice: "Comment has been approved."
  end

  # PATCH/PUT /a/comments/1/reject
  def reject
    @comment.mark_as_spam!
    redirect_to admin_comments_path, notice: "Comment has been rejected."
  end

  # DELETE /a/comments/1
  def destroy
    @comment.destroy
    redirect_to admin_comments_path, notice: 'Comment was successfully destroyed.'
  end

  def destroy_batch
    Comment.destroy(params[:comment_ids])
    redirect_to admin_comments_path, notice: "Successfully destroyed comments."
  end

  private

  def load_comment
    @comment ||= comment_scope.find(params[:id])
  end

  def load_comments
    query         = Sanitize.clean(params[:search])
    page          = params[:page] || 1
    sort_order    = Sanitize.clean(sort_column + " " + sort_direction)
    @comments ||= comment_scope.paginate(:page => page, :per_page => 10).reorder(sort_order)
  end

  def comment_scope
    Comment.all
  end

  def sort_column
    sort      = Sanitize.clean(params[:sort])
    Comment.column_names.include?(sort) ? sort : "created_at"
  end

  def sort_direction
    direction = Sanitize.clean(params[:direction])
    %w[asc desc].include?(direction) ? direction : "desc"
  end
end
