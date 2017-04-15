# This migration comes from kanban (originally 20170414150932)
class CreateKanbanColumns < ActiveRecord::Migration[5.0]
  def change
    create_table :kanban_columns do |t|
      t.string :name
      t.integer :project_id
      t.integer :position
      t.text :settings

      t.timestamps
    end
    add_index :kanban_columns, :project_id
  end
end
