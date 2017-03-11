class OutsideLab < Enumeration
  has_many :billings

  OptionName = :enumeration_outside_lab
  
  def option_name
    OptionName
  end

  def objects
    Billing.where(:outside_lab_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:outside_lab_id => to.id)
  end
end