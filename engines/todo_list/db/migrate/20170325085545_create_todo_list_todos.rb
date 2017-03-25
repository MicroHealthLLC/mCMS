class CreateTodoListTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_list_todos do |t|
      t.integer :user_id
      t.text :todos

      t.timestamps
    end
    add_index :todo_list_todos, :user_id

    modules = ['todos']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
  end
end
