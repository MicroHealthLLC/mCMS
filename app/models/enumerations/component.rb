class Component < Enumeration
  has_many :service_histories

  OptionName = :enumeration_component

  def option_name
    OptionName
  end

  def objects
    ServiceHistory.where(:component_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:component_id => to.id)
  end
end