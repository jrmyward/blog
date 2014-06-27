class ListSubscribersController < ApplicationController
  respond_to :html, :js

  # GET /subscribers/new
  def new
    @list_subscriber = ListSubscriber.new
  end

  # POST /subscribers/confirm
  def create
    @list_subscriber = ListSubscriber.new(params[:list_subscriber])
    if @list_subscriber.save
      ListSubscriberWorker.perform_async(@list_subscriber.id)
      flash[:notice] = 'Thank you for signing up for The Wayward Traveler Newsletter.'
    end
    respond_with @list_subscriber, location: posts_path
  end

  # POST /subscribers/confirm?ocd=
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
