class Procedure < Enumeration
  has_many :appointment_captures

  OptionName = :enumeration_procedure

  def option_name
    OptionName
  end

  def objects
    AppointmentCapture.where(:procedure_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:procedure_id => to.id)
  end
end