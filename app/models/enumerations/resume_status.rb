class ResumeStatus < Enumeration
  has_many :resumes

  OptionName = :enumeration_resume_status

  def option_name
    OptionName
  end

  def objects
    Resume.where(:resume_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:resume_status_id => to.id)
  end
end