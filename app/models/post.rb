class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :published, lambda { where('published_at <= ?', Time.now.utc) }
  scope :unpublished, lambda { where('published_at > ?', Time.now.utc) }

  validates_presence_of :abstract, :body, :description, :published_at, :title

  def last_published?
    self == self.class.published.last
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
