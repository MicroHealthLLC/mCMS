class GoalPlan < ApplicationRecord
  belongs_to :goal
  belongs_to :plan

  def self.safe_attributes
    [:plan_id, :goal_id]
  end
end
