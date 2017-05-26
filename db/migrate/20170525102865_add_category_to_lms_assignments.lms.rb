# This migration comes from lms (originally 20150525223719)
class AddCategoryToLmsAssignments < ActiveRecord::Migration
  def change
    add_column :lms_assignments, :category, :string
  end
end
