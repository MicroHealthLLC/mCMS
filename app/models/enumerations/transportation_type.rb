class TransportationType < Enumeration
  has_many :transportations

  OptionName = :enumeration_transportation_type

  def option_name
    OptionName
  end

  def objects
    Transportation.where(:transportation_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:transportation_type_id => to.id)
  end
end