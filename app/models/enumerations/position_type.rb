class PositionType < Enumeration
  has_many :jobs

  OptionName = :enumeration_position_type

  def option_name
    OptionName
  end

  def objects
    Job.where(:position_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:position_type_id => to.id)
  end
end