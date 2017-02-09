class FinancialStatus < Enumeration
  has_many :financials

  OptionName = :enumeration_financial_status

  def option_name
    OptionName
  end

  def objects
    Financial.where(:financial_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:financial_status_id => to.id)
  end
end