class RadiologicResultStatus < Enumeration
  has_many :radiologic_examinations

  OptionName = :enumeration_radiologic_result_status

  def option_name
    OptionName
  end

  def objects
    RadiologicExamination.where(:radiologic_result_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:radiologic_result_status_id => to.id)
  end
end