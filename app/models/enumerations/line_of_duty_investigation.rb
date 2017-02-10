class LineOfDutyInvestigation < Enumeration
  has_many :incident_histories

  OptionName = :enumeration_line_of_duty_investigation


  def option_name
    OptionName
  end

  def objects
    IncidentHistory.where(:line_of_duty_investigation_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:line_of_duty_investigation_id => to.id)
  end
end
