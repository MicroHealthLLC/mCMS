class IncidentType < Enumeration
  has_many :incident_histories

  OptionName = :enumeration_incident_type


  def option_name
    OptionName
  end

  def objects
    IncidentHistory.where(:incident_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:incident_type_id => to.id)
  end
end