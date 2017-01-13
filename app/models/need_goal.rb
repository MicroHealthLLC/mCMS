class NeedGoal < ApplicationRecord
  belongs_to :need
  belongs_to :goal
  validates_presence_of :goal_id, :need_id
end
