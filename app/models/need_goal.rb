class NeedGoal < ApplicationRecord
  belongs_to :need
  belongs_to :goal
  validates_presence_of  :need_id

  def self.safe_attributes
    [:goal_id, :need_id]
  end
end
