class ApplicationType < Enumeration
  has_many :job_applications

  OptionName = :enumeration_application_type

  def option_name
    OptionName
  end

  def objects
    JobApplication.where(:application_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:application_type_id => to.id)
  end
end