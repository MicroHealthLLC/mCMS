class HealthCareFacilityDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      HealthCareFacility.name
      Enumeration.name
      Enumeration.name
      HealthCareFacility.health_care_facility_contact
      HealthCareFacility.date_started
      HealthCareFacility.date_started
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      HealthCareFacility.name
      Enumeration.name
      Enumeration.name
      HealthCareFacility.health_care_facility_contact
      HealthCareFacility.date_started
      HealthCareFacility.date_end
    }
  end

  private

  def data
    records.map do |health_care_facility|
      [
          @view.link_to_edit_if_can( health_care_facility.name, {ctrl: :health_care_facilities, object: health_care_facility }) ,
          health_care_facility.health_care_facility_type.to_s,
          health_care_facility.health_care_facility_status.to_s ,
          health_care_facility.health_care_facility_contact ,
          @view.format_date( health_care_facility.date_started) ,
          @view.format_date( health_care_facility.date_end)
      ]

    end
  end

  def get_raw_records
    scope = HealthCareFacility.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
