class Operation < Enumeration
  has_many :incident_histories

  OptionName = :enumeration_operation


  def option_name
    OptionName
  end

  def objects
    IncidentHistory.where(:operation_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:operation_id => to.id)
  end
end