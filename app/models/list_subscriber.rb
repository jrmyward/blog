class ListSubscriber < ActiveRecord::Base

  validates_presence_of :email, :first_name
  validates_uniqueness_of :email

  def subscribe_to_list
    newsletter = NewsletterService.new
    newsletter.subscribe(self)
  end
end
