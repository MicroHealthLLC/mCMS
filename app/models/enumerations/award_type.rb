class AwardType < Enumeration
  has_many :awards

  OptionName = :enumeration_award_type

  def option_name
    OptionName
  end

  def objects
    Award.where(:award_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:award_type_id => to.id)
  end
end