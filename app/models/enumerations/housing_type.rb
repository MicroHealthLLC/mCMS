class HousingType < Enumeration
  has_many :housings

  OptionName = :enumeration_housing_type

  def option_name
    OptionName
  end

  def objects
    Housing.where(:housing_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:housing_type_id => to.id)
  end
end