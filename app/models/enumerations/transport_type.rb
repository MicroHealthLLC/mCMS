class TransportType < Enumeration
  has_many :transports

  OptionName = :enumeration_transport_type

  def option_name
    OptionName
  end

  def objects
    Transport.where(:transport_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:transport_type_id => to.id)
  end
end