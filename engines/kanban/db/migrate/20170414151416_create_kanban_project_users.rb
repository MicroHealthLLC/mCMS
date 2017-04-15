class CreateKanbanProjectUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :kanban_project_users do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
    add_index :kanban_project_users, :project_id
    add_index :kanban_project_users, :user_id

    add_column :users, :last_project_used_id, :integer
  end
end
