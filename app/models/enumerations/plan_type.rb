class PlanType < Enumeration
  has_many :plans

  OptionName = :enumeration_plan_type

  def option_name
    OptionName
  end

  def objects
    Plan.where(:plan_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:plan_type_id => to.id)
  end
end