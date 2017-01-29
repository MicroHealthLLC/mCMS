class EducationStatus < Enumeration
  has_many :educations

  OptionName = :enumeration_education_status

  def option_name
    OptionName
  end

  def objects
    Education.where(:status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:status_id => to.id)
  end
end