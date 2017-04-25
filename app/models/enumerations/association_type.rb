class AssociationType < Enumeration
  has_many :case_organizations

  OptionName = :enumeration_association

  def option_name
    OptionName
  end

  def objects
    CaseOrganization.where(:association_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:association_id => to.id)
  end
end