class CreateDmsDocumemnts < ActiveRecord::Migration[5.0]
  def change
    create_table :dms_documemnts do |t|
      t.integer :document_manager_id
      t.string :doc

      t.timestamps
    end
  end
end
