# This migration comes from rordit (originally 20161231145120)
class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.string :hostname
      t.float :popularity, default: 0.0
      t.integer :comments_count, default: 0
      t.integer :points_count, default: 0
      t.string :username
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :links, :user_id
  end
end
