class AddDueDateToLmsAssignments < ActiveRecord::Migration
  def change
    add_column :lms_assignments, :due_date, :datetime
  end
end
