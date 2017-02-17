class MedicalHistoryStatus < Enumeration
  has_many :medicals

  OptionName = :enumeration_medical_history_status

  def option_name
    OptionName
  end

  def objects
    Medical.where(:medical_history_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:medical_history_status_id => to.id)
  end
end