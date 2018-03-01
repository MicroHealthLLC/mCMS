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
          @view.link_to_edit_if_can(identification.identification_type, {ctrl: :identifications, object: identification }),
          identification.identification_number,
          identification.status,
          @view.format_date( identification.date_expired),
          identification.issued_by_type,
          @view.format_date( identification.date_issued)
      ]
    end
  end

  def get_raw_records
    scope = User.current.extend_informations.identifications.include_enumerations
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
