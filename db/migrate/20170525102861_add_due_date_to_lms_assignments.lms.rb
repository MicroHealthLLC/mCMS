# This migration comes from lms (originally 20150513210722)
class AddDueDateToLmsAssignments < ActiveRecord::Migration
  def change
    add_column :lms_assignments, :due_date, :datetime
  end
end
