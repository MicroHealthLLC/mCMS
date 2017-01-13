class CreateNeedGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :need_goals do |t|
      t.integer :need_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
