# This migration comes from kanban (originally 20170412133734)
class CreateKanbanProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :kanban_projects do |t|
      t.string :name
      t.integer :number_of_columns
      t.text :settings

      t.timestamps
    end
  end
end
