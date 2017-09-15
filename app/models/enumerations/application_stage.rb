class ApplicationStage < Enumeration
  has_many :jobs

  OptionName = :enumeration_application_stages

  def option_name
    OptionName
  end

  def objects
    Job.where(:application_stage_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:application_stage_id => to.id)
  end
end