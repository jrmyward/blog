class Comment < ActiveRecord::Base
  include Rakismet::Model
  has_ancestry

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

  def mark_as_ham!
    update_attribute(:approved, true)
    self.ham!
  end

  def mark_as_spam!
    update_attribute(:approved, false)
    self.spam!
  end

  private

  def check_for_spam
    self.approved = !self.spam?
    true
  end

  # def notify_other_commenters
  #   users_to_notify.each do |user|
  #     Mailer.comment_response(self, user).deliver
  #   end
  # end

  # def users_to_notify
  #   ancestors.map(&:user).compact.select { |u| u.email.present? && u.email_on_reply? && u != user }
  # end
end
