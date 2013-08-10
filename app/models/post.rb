class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :comments, as: :commentable, :dependent => :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable

  scope :published, lambda { where('published_at <= ?', Time.now.utc) }
  scope :unpublished, lambda { where('published_at > ?', Time.now.utc) }

  mount_uploader :image, ImageUploader

  validates_presence_of :abstract, :body, :description, :published_at, :title

  def editable_by?(user)
    return false if user.nil?
    user.admin? or user.id == author_id
  end

  def is_commentable?
    is_commentable
  end

  def last_published?
    self == self.class.published.last
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end