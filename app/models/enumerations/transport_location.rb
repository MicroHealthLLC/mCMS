class TransportLocation < Enumeration
  has_many :transports

  OptionName = :enumeration_transport_location

  def option_name
    OptionName
  end

  def objects
    Transport.where(:transport_location_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:transport_location_id => to.id)
  end
end