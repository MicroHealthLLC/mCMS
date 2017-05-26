# This migration comes from lms (originally 20150510132717)
class CreateLmsCourses < ActiveRecord::Migration
  def change
    create_table :lms_courses do |t|
      t.string :name
      t.text :description
      t.string :course_code

      t.timestamps null: false
    end
  end
end
