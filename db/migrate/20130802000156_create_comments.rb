class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :commentable, polymorphic: true
      t.text :body
      t.string :email
      t.string :site_url
      t.string :user_ip
      t.string :user_agent
      t.string :referrer
      t.boolean :approved, :default => false, :null => false
      t.timestamps
    end
    add_index :comments, :commentable_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
