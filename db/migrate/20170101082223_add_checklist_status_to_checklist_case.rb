class AddChecklistStatusToChecklistCase < ActiveRecord::Migration[5.0]
  def change
    add_column :checklist_cases, :checklist_status_type_id, :integer
  end
end
