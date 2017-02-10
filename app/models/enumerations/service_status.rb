class ServiceStatus < Enumeration
  has_many :service_histories

  OptionName = :enumeration_service_status

  def option_name
    OptionName
  end

  def objects
    ServiceHistory.where(:service_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:service_status_id => to.id)
  end
end