class DispositionRelatedTo < Enumeration
  has_many :appointment_dispositions

  OptionName = :enumeration_related_to

  def option_name
    OptionName
  end

  def objects
    AppointmentDisposition.where(:related_to_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:related_to_id => to.id)
  end
end