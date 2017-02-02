class ContactMethod < Enumeration
  has_many :teleconsults

  OptionName = :enumeration_contact_method

  def option_name
    OptionName
  end

  def objects
    Teleconsult.where(:contact_method_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:contact_method_id => to.id)
  end
end