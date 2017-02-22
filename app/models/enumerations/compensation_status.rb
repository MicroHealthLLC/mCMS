class CompensationStatus < Enumeration
  has_many :worker_compensations

  OptionName = :enumeration_compensation_status

  def option_name
    OptionName
  end

  def objects
    WorkerCompensation.where(:compensation_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:compensation_status_id => to.id)
  end
end