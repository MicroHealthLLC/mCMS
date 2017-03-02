class PlanTask < ApplicationRecord
  belongs_to :plan
  belongs_to :task

  def self.safe_attributes
    [:plan_id, :task_id]
  end
end
