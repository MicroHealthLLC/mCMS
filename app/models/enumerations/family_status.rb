class FamilyStatus < Enumeration
  has_many :surgicals

  OptionName = :enumeration_family_status

  def option_name
    OptionName
  end

  def objects
    FamilyHistory.where(:family_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:family_status_id => to.id)
  end
end