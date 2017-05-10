class GoalType < Enumeration
  has_many :goals

  OptionName = :enumeration_goal_type

  def option_name
    OptionName
  end

  def objects
    Goal.where(:goal_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:goal_type_id => to.id)
  end
end