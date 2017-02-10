class AwardEnum < Enumeration
  has_many :awards

  OptionName = :enumeration_award_enum

  def option_name
    OptionName
  end

  def objects
    Award.where(:award_enum_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:award_enum_id => to.id)
  end
end