class CreatePlannerKanbans < ActiveRecord::Migration[5.0]
  def change
    create_table :planner_kanbans do |t|

      t.timestamps
    end
  end
end
