class HealthCareFacilityType < Enumeration
  has_many :health_care_facilities

  OptionName = :enumeration_health_care_facility_type

  def option_name
    OptionName
  end

  def objects
    HealthCareFacility.where(:health_care_facility_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:health_care_facility_type_id => to.id)
  end
end