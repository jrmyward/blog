class AddIsCommentableToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_commentable, :boolean
  end
end
