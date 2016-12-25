class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :priority_type, optional: true
  belongs_to :goal_status, optional: true

  has_many :goal_notes, foreign_key: :owner_id

  validates_presence_of :name
  def self.safe_attributes
    [
        :priority_type_id, :user_id, :goal_status_id, :name,
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

  def goal_status
    if goal_status_id
      super
    else
      GoalStatus.default
    end
  end
end
