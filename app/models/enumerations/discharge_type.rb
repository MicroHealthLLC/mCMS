class DischargeType < Enumeration
  has_many :service_histories

  OptionName = :enumeration_discharge_type

  def option_name
    OptionName
  end

  def objects
    ServiceHistory.where(:discharge_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:discharge_type_id => to.id)
  end
end