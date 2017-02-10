class IncidentCategory < Enumeration
  has_many :incident_histories

  OptionName = :enumeration_incident_category


  def option_name
    OptionName
  end

  def objects
    IncidentHistory.where(:incident_category_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:incident_category_id => to.id)
  end
end