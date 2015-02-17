class Comment < ActiveRecord::Base
  include Rakismet::Model
  has_ancestry

  belongs_to :commentable, polymorphic: true, touch: true

  scope :published, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

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

  def notify_other_commenters
    Mailer.notify_admin_and_author(self).deliver_now
    Mailer.comment_response(self, parent).deliver_now if !!parent && self.approved?
  end

  private

  def check_for_spam
    self.approved = !self.spam?
    true
  end
end
