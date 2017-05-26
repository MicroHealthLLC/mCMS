# This migration comes from lms (originally 20150517235735)
class CreateLmsStudentAssignments < ActiveRecord::Migration
  def change
    create_table :lms_student_assignments do |t|
      t.integer :assignment_id
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
