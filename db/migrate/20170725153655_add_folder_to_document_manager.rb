class AddFolderToDocumentManager < ActiveRecord::Migration[5.0]
  def change
    add_column :document_managers, :folder_id, :integer
    add_index :document_managers, :folder_id
  end
end
