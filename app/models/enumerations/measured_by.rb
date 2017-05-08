class MeasuredBy < Enumeration
  has_many :measurements

  OptionName = :enumeration_measured_by

  def option_name
    OptionName
  end

  def objects
    Measurement.where(:measured_by_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:measured_by_id => to.id)
  end
end