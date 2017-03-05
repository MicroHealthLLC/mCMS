class CaseSupportType < Enumeration
  has_many :case_supports

  OptionName = :enumeration_case_support_type

  def option_name
    OptionName
  end

  def objects
    CaseSupport.where(:case_support_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:case_support_type_id => to.id)
  end
end