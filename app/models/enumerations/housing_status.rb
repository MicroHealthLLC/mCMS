class HousingStatus < Enumeration
  has_many :housings

  OptionName = :enumeration_housing_status

  def option_name
    OptionName
  end

  def objects
    Housing.where(:housing_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:housing_status_id => to.id)
  end
end