class DeploymentOperation < Enumeration
  has_many :deployment_histories

  OptionName = :enumeration_deployment_operation


  def option_name
    OptionName
  end

  def objects
    DeploymentHistory.where(:deployment_operation_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:deployment_operation_id => to.id)
  end
end