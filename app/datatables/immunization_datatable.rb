class ImmunizationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Immunization.snomed
      Immunization.next_date_due
      Immunization.date_immunized
      Immunization.manufacturer
      Immunization.lot_number
      Immunization.expiration_date
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Immunization.snomed
      Immunization.next_date_due
      Immunization.date_immunized
      Immunization.manufacturer
      Immunization.lot_number
      Immunization.expiration_date
      Enumeration.name
    }
  end

  private

  def data
    records.map do |immunization|
      [
          @view.link_to_edit_if_can( immunization.snomed, {ctrl: :immunizations, object: immunization }) ,
          @view.format_date(immunization.next_date_due ),
          @view.format_date( immunization.date_immunized) ,
          immunization.manufacturer ,
          immunization.lot_number ,
          @view.format_date( immunization.expiration_date) ,
          immunization.immunization_status.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = Immunization.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
