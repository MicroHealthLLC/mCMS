class ImmunizationStatus < Enumeration
  has_many :immunizations

  OptionName = :enumeration_immunization_status

  def option_name
    OptionName
  end

  def objects
    Immunization.where(:immunization_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:immunization_status_id => to.id)
  end
end