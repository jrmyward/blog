class ListSubscribersController < ApplicationController
  # before_action :set_list_subscriber, only: [:show, :edit, :update, :destroy]

  # GET /subscribers/new
  def new
    @list_subscriber = ListSubscriber.new
  end

  # POST /subscribers/confirm
  def create
    @list_subscriber = ListSubscriber.new(params[:list_subscriber])

    respond_to do |format|
      if @list_subscriber.save
        @list_subscriber.subscribe_to_list
        flash["notice"] = 'Thank you for signing up for the Fitrme Newsletter.'
        format.html do
          redirect_to posts_path
        end
        format.js
      else
        format.html do
          render action: 'new'
        end
        format.js
      end
    end
  end

  # POST /subsribers/confirm?ocd=
  def confirm
    if request.post?
      if params["ocd"] == Rails.application.secrets.mail_chimp_webhook_token
        verify_data
      else
        render nothing: true, status: :precondition_failed
      end
    else
      render nothing: true, status: :ok
    end
  end

  private

  def update_subscriber
    subscriber = ListSubscriber.find_by(email: params["data"]["email"])
    if subscriber
      subscriber.update_attribute(:confirmed, true)
      render nothing: true, status: :accepted
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def verify_data
    if params["data"] and params["data"]["email"]
      update_subscriber
    else
      render nothing: true, status: :expectation_failed
    end
  end

end
