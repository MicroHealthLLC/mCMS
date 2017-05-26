# This migration comes from lms (originally 20150514170406)
class CreateLmsCourseLinks < ActiveRecord::Migration
  def change
    create_table :lms_course_links do |t|
      t.integer :course_id
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
