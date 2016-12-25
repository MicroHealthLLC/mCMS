class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :priority_type, optional: true
  belongs_to :plan_status, optional: true
  validates_presence_of :name
  has_many :plan_notes, foreign_key: :owner_id
  def self.safe_attributes
    [
        :priority_type_id, :user_id, :plan_status_id, :name,
        :description, :date_completed, :date_due,  :case_id
    ]
  end

  def priority_type
    if priority_type_id
      super
    else
      PriorityType.default
    end
  end

  def plan_status
    if plan_status_id
      super
    else
      PlanStatus.default
    end
  end
end
