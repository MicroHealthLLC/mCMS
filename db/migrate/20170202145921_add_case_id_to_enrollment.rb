class AddCaseIdToEnrollment < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :case_id, :integer
  end
end
