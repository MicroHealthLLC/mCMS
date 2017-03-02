class PlanTask < ApplicationRecord
  belongs_to :plan
  belongs_to :task

  def self.safe_attributes
    [:id, :plan_id, :task_id]
  end
end
