class AddChecklistStatusIdToChecklistTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :checklist_templates, :checklist_status_type_id, :integer
  end
end
