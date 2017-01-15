class CreatePlanTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :plan_tasks do |t|
      t.integer :plan_id
      t.integer :task_id

      t.timestamps
    end
  end
end
