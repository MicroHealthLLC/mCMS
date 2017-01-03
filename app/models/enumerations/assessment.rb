class Assessment < Enumeration
  has_many :appointment_captures

  OptionName = :enumeration_assessment

  def option_name
    OptionName
  end

  def objects
    AppointmentCapture.where(:assessment_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:assessment_id => to.id)
  end
end