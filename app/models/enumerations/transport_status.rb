class TransportStatus < Enumeration
  has_many :transports

  OptionName = :enumeration_transport_status

  def option_name
    OptionName
  end

  def objects
    Transport.where(:transport_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:transport_status_id => to.id)
  end
end