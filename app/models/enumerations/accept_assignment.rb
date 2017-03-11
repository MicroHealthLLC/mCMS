class AcceptAssignment < Enumeration
  has_many :billings

  OptionName = :enumeration_accept_assignment

  def option_name
    OptionName
  end

  def objects
    Billing.where(:accept_assignment_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:accept_assignment_id => to.id)
  end
end