class AdmissionType < Enumeration
  has_many :admissions

  OptionName = :enumeration_admission_type

  def option_name
    OptionName
  end

  def objects
    Admission.where(:admission_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:admission_type_id => to.id)
  end
end