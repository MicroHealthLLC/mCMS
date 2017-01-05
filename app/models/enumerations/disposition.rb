class Disposition < Enumeration
  has_many :appointment_captures

  OptionName = :enumeration_disposition

  def option_name
    OptionName
  end

  def objects
    AppointmentCapture.where(:disposition_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:disposition_id => to.id)
  end
end