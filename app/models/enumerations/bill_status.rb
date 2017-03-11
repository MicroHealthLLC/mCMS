class BillStatus < Enumeration
  has_many :billings

  OptionName = :enumeration_bill_status

  def option_name
    OptionName
  end

  def objects
    Billing.where(:bill_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:bill_status_id => to.id)
  end
end