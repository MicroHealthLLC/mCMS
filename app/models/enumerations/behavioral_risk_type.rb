class BehavioralRiskType < Enumeration
  has_many :behavioral_risks

  OptionName = :enumeration_behavioral_risk_type

  def option_name
    OptionName
  end

  def objects
    BehavioralRisk.where(:behavioral_risk_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:behavioral_risk_type_id => to.id)
  end
end