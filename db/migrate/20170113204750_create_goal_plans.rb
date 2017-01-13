class CreateGoalPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :goal_plans do |t|
      t.integer :plan_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
