class VerifiedPersonnelCasualtyReportingSystem < Enumeration
  has_many :incident_histories

  OptionName = :enumeration_verified_personnel_casualty_reporting_system


  def option_name
    OptionName
  end

  def objects
    IncidentHistory.where(:verified_personnel_casualty_reporting_system_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:verified_personnel_casualty_reporting_system_id => to.id)
  end
end
