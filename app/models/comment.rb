class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  scope :published, lambda { where(:approved => true) }
  scope :unapproved, lambda { where(:approved => false) }

  validates_presence_of :body, :email, :name
  validates_format_of :email,
    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "Invalid email format.",
    :if => "email.present?"

  before_create :check_for_spam

  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end

  private

  def check_for_spam
    self.approved = !self.spam?
    true
  end
end
