class HousingDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Housing.snomed
      Enumeration.name
      Housing.address
      Housing.estimated_monthly_payment
      Housing.date_start
      Housing.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Housing.snomed
      Enumeration.name
      Housing.address
      Housing.estimated_monthly_payment
      Housing.date_start
      Housing.date_end
    }
  end

  private

  def data
    records.map do |housing|
      [
          @view.link_to_edit_if_can((housing.snomed || housing.id), {ctrl: :housings, object: housing } ),
          housing.housing_status.to_s ,
          housing.address ,
          housing.estimated_monthly_payment ,
          @view.format_date(housing.date_start) ,
          @view.format_date( housing.date_end )
      ]

    end
  end

  def get_raw_records
    scope = Housing.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
