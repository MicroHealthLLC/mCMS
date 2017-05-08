class MeasurementName < Enumeration
  has_many :measurements

  OptionName = :enumeration_measurement_name

  def option_name
    OptionName
  end

  def objects
    Measurement.where(:measurement_name_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:measurement_name_id => to.id)
  end
end