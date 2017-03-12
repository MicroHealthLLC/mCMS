class LaboratoryResultStatus < Enumeration
  has_many :laboratory_examinations

  OptionName = :enumeration_laboratory_result_status

  def option_name
    OptionName
  end

  def objects
    LaboratoryExamination.where(:laboratory_result_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:laboratory_result_status_id => to.id)
  end
end