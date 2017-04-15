# This migration comes from kanban (originally 20170414150940)
class CreateKanbanCards < ActiveRecord::Migration[5.0]
  def change
    create_table :kanban_cards do |t|
      t.string :name
      t.text :description
      t.string :color
      t.integer :created_by_id
      t.date :start_date
      t.date :due_date
      t.date :date_completed
      t.integer :column_id
      t.integer :project_id
      t.boolean :is_archived, default: false
      t.datetime :archived_on

      t.timestamps
    end
    add_index :kanban_cards, :column_id
  end
end
