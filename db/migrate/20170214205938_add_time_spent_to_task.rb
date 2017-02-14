class AddTimeSpentToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :time_spent, :string
  end
end
