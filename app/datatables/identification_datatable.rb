class IdentificationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Identification.identification_number
      Enumeration.name
      Identification.date_expired
      Enumeration.name
      Identification.date_issued
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Identification.identification_number
      Enumeration.name
      Identification.date_expired
      Enumeration.name
      Identification.date_issued
      Enumeration.name
    }
  end

  private

  def data
    records.map do |identification|
      [
          @view.link_to_edit_if_can(identification.identification_type, {ctrl: :identifications, object: identification }),
          identification.identification_number,
          identification.identification_status,
          @view.format_date( identification.date_expired),
          identification.issued_by_type,
          @view.format_date( identification.date_issued)
      ]
    end
  end

  def get_raw_records
    user.current.extend_informations.identifications.include_enumerations
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
