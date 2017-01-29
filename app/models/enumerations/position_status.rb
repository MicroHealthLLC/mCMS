class PositionStatus < Enumeration
  has_many :positions

  OptionName = :enumeration_position_status

  def option_name
    OptionName
  end

  def objects
    Position.where(:status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:status_id => to.id)
  end
end