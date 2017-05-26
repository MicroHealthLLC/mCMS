class AddCompletedToLmsStudentAssignments < ActiveRecord::Migration
  def change
    add_column :lms_student_assignments, :completed, :boolean
  end
end
