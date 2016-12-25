class GoalNote < Note
  belongs_to :goal, foreign_key: :owner_id, class_name: 'Goal'

  def object
    goal
  end

end
