class TransportationStatus < Enumeration
  has_many :transportations

  OptionName = :enumeration_transportation_status

  def option_name
    OptionName
  end

  def objects
    Transportation.where(:transportation_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:transportation_status_id => to.id)
  end
end