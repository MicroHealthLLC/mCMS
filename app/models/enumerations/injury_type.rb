class InjuryType < Enumeration
  has_many :injuries

  OptionName = :enumeration_injury_type

  def option_name
    OptionName
  end

  def objects
    Injury.where(:injury_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:injury_type_id => to.id)
  end
end