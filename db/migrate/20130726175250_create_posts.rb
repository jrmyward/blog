class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.string :slug
      t.text :description
      t.text :abstract
      t.text :body
      t.timestamp :published_at

      t.timestamps
    end
    add_index :posts, :author_id
    add_index :posts, :title
    add_index :posts, :slug, unique: true
    add_index :posts, :published_at
  end
end
