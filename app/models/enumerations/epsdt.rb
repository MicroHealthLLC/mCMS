class Epsdt < Enumeration
  has_many :appointment_procedures

  OptionName = :enumeration_epsdt

  def option_name
    OptionName
  end

  def objects
    AppointmentProcedure.where(:epsdt_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:epsdt_id => to.id)
  end
end