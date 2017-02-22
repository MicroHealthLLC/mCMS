class InjuryStatus < Enumeration
  has_many :injuries

  OptionName = :enumeration_injury_status

  def option_name
    OptionName
  end

  def objects
    Injury.where(:injury_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:injury_status_id => to.id)
  end
end