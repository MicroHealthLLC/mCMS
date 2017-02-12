class ChangeChecklist < ActiveRecord::Migration[5.0]
  def change
    rename_column :checklist_templates, :checklist_type, :checklist_type_id
    ChecklistTemplate.where(nil).update_all({checklist_type_id: nil})
    change_column :checklist_templates, :checklist_type_id, :integer
  end
end
