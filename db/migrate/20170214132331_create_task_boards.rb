class CreateTaskBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :task_boards do |t|
      t.integer :user_id
      t.text :todos

      t.timestamps
    end
    add_index :task_boards, :user_id

    modules = ['sticky']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end

  end
end
