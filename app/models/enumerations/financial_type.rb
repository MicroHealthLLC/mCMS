class FinancialType < Enumeration
  has_many :financials

  OptionName = :enumeration_financial_type

  def option_name
    OptionName
  end

  def objects
    Financial.where(:financial_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:financial_type_id => to.id)
  end
end