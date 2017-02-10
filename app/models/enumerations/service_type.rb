class ServiceType < Enumeration
  has_many :service_histories

  OptionName = :enumeration_service_type

  def option_name
    OptionName
  end

  def objects
    ServiceHistory.where(:service_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:service_type_id => to.id)
  end
end