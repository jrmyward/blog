class CreateListSubscribers < ActiveRecord::Migration
  def change
    create_table :list_subscribers do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :postal_code
      t.boolean :confirmed, :default => false, :null => false

      t.timestamps
    end
    add_index :list_subscribers, :email, :unique => true
    add_index :list_subscribers, :postal_code
    add_index :list_subscribers, :confirmed
  end
end
