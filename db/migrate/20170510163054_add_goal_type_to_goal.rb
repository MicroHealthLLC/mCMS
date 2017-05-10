class AddGoalTypeToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :goal_type_id, :integer
  end
end
