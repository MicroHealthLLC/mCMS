class AddOrganizationToNoteTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :note_templates, :organization_id, :integer
    add_index :note_templates, :organization_id
  end
end
