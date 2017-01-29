class InsuranceStatus < Enumeration
  has_many :user_insurances

  OptionName = :enumeration_insurance_status

  def option_name
    OptionName
  end

  def objects
    UserInsurance.where(:status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:status_id => to.id)
  end
end