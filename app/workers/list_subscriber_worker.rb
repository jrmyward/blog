class ListSubscriberWorker
  include Sidekiq::Worker

  def perform(list_subscriber_id)
    list_subscriber = ListSubscriber.find(list_subscriber_id)
    list_subscriber.subscribe_to_list
  end
end