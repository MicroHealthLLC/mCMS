class AddCategoryToLmsAssignments < ActiveRecord::Migration
  def change
    add_column :lms_assignments, :category, :string
  end
end
