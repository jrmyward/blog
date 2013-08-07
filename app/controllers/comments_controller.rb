class CommentsController < ApplicationController
  prepend_before_action :merge_params, only: [:create, :update]
  prepend_before_action :load_commentable, only: [:new, :create, :edit, :update]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  prepend_before_action :authenticate_user!, :except => [:index, :new, :create]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # def show
  # end

  # GET /comments/new
  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(params[:comment].to_h)

    if @comment.save
      if @comment.approved?
        flash[:notice] = "Thanks for the comment!"
      else
        flash[:error] = "Unfortunately this comment is considered spam by Akismet. " +
                      "It will show up once it has been approved by the administrator."
      end
      redirect_to @commentable
    else
      redirect_to @commentable
    end

  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private

    def merge_params
      params[:comment].merge!({
        user_ip: request.remote_ip,
        user_agent: request.env['HTTP_USER_AGENT'],
        referrer: request.env['HTTP_REFERER'],
        approved: false,
        commentable_id: @commentable.id,
        commentable_type: @commentable.class.to_s
      })
    end

    def load_commentable
      resource, id = request.path.split('/')[2, 3] # /blog/article/1
      @commentable = resource.singularize.classify.constantize.friendly.find(id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
end
