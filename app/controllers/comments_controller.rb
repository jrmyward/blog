class CommentsController < ApplicationController
  prepend_before_filter :authenticate_user!, :except => [:index, :new, :create]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render action: 'new'
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
    def load_commentable
      resource, id = request.path.split('/')[2, 3] # /blog/article/1
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
end
