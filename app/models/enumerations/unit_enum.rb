class UnitEnum < Enumeration
  has_many :units

  OptionName = :enumeration_unit_enum

  def option_name
    OptionName
  end

  def objects
    Unit.where(:unit_enum_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:unit_enum_id => to.id)
  end
end