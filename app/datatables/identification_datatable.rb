class IdentificationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Identification.identification_number
      Identification.status
      Identification.date_expired
      Identification.issued_by_type_id
      Identification.date_issued
      Identification.identification_type_id
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Identification.identification_number
      Identification.status
      Identification.date_expired
      Identification.issued_by_type_id
      Identification.date_issued
      Identification.identification_type_id
    }
  end

  private

  def data
    records.map do |identification|
      [
          @view.link_to_edit_if_can(identification.issued_by_type_id, {ctrl: :identifications, object: identification }),
          identification.identification_number,
          identification.status,
          identification.identification_type_id,
          @view.format_date( identification.date_expired),
          @view.format_date( identification.date_issued),
      ]
    end
  end

  def get_raw_records
    scope = Identification.include_enumerations
    scope.for_status @options[:status]
    scope.for_identification_type_id @options[:identification_type_id]
    scope.for_issued_by_type_id @options[:issued_by_type_id]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
