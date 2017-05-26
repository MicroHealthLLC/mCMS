# This migration comes from lms (originally 20150518224625)
class AddCompletedToLmsStudentAssignments < ActiveRecord::Migration
  def change
    add_column :lms_student_assignments, :completed, :boolean
  end
end
