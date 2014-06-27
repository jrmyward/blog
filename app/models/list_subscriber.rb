class ListSubscriber < ActiveRecord::Base

  validates_presence_of :email, :first_name
  validates_uniqueness_of :email

  def newsletter_service
    @newsletter ||= NewsletterService.new
  end

  def subscribe_to_list
    newsletter_service.subscribe(self)
  end
end
