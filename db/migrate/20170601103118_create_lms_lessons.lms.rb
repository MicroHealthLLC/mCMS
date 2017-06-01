# This migration comes from lms (originally 20170601095132)
class CreateLmsLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lms_lessons do |t|
      t.integer :user_id
      t.integer :course_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :lms_lessons, :user_id
    add_index :lms_lessons, :course_id
  end
end
