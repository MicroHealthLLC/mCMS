class EnvironmentType < Enumeration
  has_many :environment_risks

  OptionName = :enumeration_environment_type

  def option_name
    OptionName
  end

  def objects
    EnvironmentRisk.where(:environment_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:environment_type_id => to.id)
  end
end