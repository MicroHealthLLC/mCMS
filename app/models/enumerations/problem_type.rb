class ProblemType < Enumeration
  has_many :problem_lists

  OptionName = :enumeration_problem_type

  def option_name
    OptionName
  end

  def objects
    ProblemList.where(:problem_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:problem_type_id => to.id)
  end
end