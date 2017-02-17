class MedicationStatus < Enumeration
  has_many :medications

  OptionName = :enumeration_medication_status

  def option_name
    OptionName
  end

  def objects
    Medication.where(:medication_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:medication_status_id => to.id)
  end
end