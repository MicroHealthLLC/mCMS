# This migration comes from rordit (originally 20161231145431)
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :points_count, default: 0
      t.string :username
      t.integer :user_id
      t.integer :link_id

      t.timestamps null: false
    end
    add_index :comments, :user_id
    add_index :comments, :link_id
  end
end
