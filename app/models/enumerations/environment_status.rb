class EnvironmentStatus < Enumeration
  has_many :environment_risks

  OptionName = :enumeration_environment_status

  def option_name
    OptionName
  end

  def objects
    EnvironmentRisk.where(:environment_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:environment_status_id => to.id)
  end
end