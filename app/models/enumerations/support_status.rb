class SupportStatus < Enumeration
  has_many :case_supports

  OptionName = :enumeration_support_status

  def option_name
    OptionName
  end

  def objects
    CaseSupport.where(:support_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:support_status_id => to.id)
  end
end