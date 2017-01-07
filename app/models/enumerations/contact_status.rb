class ContactStatus < Enumeration
  has_many :contacts

  OptionName = :enumeration_contact_status

  def option_name
    OptionName
  end

  def objects
    Contact.where(:contact_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:contact_status_id => to.id)
  end
end