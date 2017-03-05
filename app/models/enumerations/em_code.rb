class EmCode < Enumeration
  has_many :appointment_procedures

  OptionName = :enumeration_em_code

  def option_name
    OptionName
  end

  def objects
    AppointmentProcedure.where(:em_code_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:em_code_id => to.id)
  end
end