class AppointmentStatus < Enumeration
  has_many :appointments

  OptionName = :enumeration_appointment_status

  def option_name
    OptionName
  end

  def objects
    Appointment.where(:appointment_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:appointment_status_id => to.id)
  end
end