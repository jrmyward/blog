class CommentsController < ApplicationController
  prepend_before_action :merge_params, only: [:create, :update]
  prepend_before_action :load_commentable, only: [:new, :create, :edit, :update]
  prepend_before_action :authenticate_user!, :except => [:index, :new, :create]

  # GET /comments/new
  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  # POST /comments
  def create
    @comment = Comment.new(params[:comment].to_h)

    if @comment.save
      if @comment.approved?
        # @comment.notify_other_commenters
      else
        flash[:error] = "Unfortunately this comment is considered spam by Akismet. " +
                      "It will show up once it has been approved by the administrator."
      end
    end

    respond_to do |format|
      format.html do
        if @comment.errors.present?
          render :new
        else
          redirect_to @commentable, :view => "comments"
        end
      end
      format.js
    end

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

end
