class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.text :abstract
      t.text :body
      t.timestamp :published_at

      t.timestamps
    end
    add_index :posts, :title
    add_index :posts, :slug
    add_index :posts, :published_at
  end
end
