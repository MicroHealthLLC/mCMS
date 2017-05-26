# This migration comes from lms (originally 20150510140122)
class AddTeacherIdToLmsCourses < ActiveRecord::Migration
  def change
    add_column :lms_courses, :teacher_id, :integer
    add_index :lms_courses, :teacher_id
  end
end
