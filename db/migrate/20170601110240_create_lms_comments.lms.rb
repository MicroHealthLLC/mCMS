# This migration comes from lms (originally 20170601105731)
class CreateLmsComments < ActiveRecord::Migration[5.0]
  def change
    create_table :lms_comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :lesson_id

      t.timestamps
    end
    add_index :lms_comments, :user_id
    add_index :lms_comments, :lesson_id
  end
end
