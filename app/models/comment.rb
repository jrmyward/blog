class Comment < ActiveRecord::Base
  include Rakismet::Model
  belongs_to :commentable, polymorphic: true

  scope :published, lambda { where(:approved => true) }
  scope :unapproved, lambda { where(:approved => false) }

  rakismet_attrs :author => :name, :author_email => :email, :author_url => :site_url, :author_ip => :user_ip

  validates_presence_of :body, :email, :name
  validates_format_of :email,
    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "Invalid email format.",
    :if => "email.present?"

  before_create :check_for_spam

  private

  def check_for_spam
    self.approved = !self.spam?
    true
  end
end
