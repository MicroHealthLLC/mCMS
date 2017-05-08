class MeasurementStatus < Enumeration
  has_many :measurement_records

  OptionName = :enumeration_measurement_status

  def option_name
    OptionName
  end

  def objects
    MeasurementRecord.where(:measurement_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:measurement_status_id => to.id)
  end
end