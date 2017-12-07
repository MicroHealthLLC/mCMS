class TransportationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Enumeration.name
      Enumeration.name
      Transportation.estimated_monthly_cost
      Transportation.date_start
      Transportation.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Enumeration.name
      Enumeration.name
      Transportation.estimated_monthly_cost
      Transportation.date_start
      Transportation.date_end
    }
  end

  private

  def data
    records.map do |transportation|
      [
          @view.link_to_edit_if_can( transportation.transportation_mean, {ctrl: :transportations, object: transportation } ),

          transportation.transportation_type.to_s ,
          transportation.transportation_accessibility.to_s ,
          transportation.transportation_status.to_s ,

          transportation.estimated_monthly_cost ,
          @view.format_date( transportation.date_start) ,
          @view.format_date( transportation.date_end)
      ]

    end
  end

  def get_raw_records
    scope = Transportation.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
