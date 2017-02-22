class InterviewType < Enumeration
  has_many :job_applications

  OptionName = :enumeration_interview_type

  def option_name
    OptionName
  end

  def objects
    JobApplication.where(:interview_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:interview_type_id => to.id)
  end
end