class ClearanceDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Clearance.date_received
      Clearance.date_expired
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Clearance.date_received
      Clearance.date_expired
    }
  end

  private

  def data
    records.map do |clearance|
      [
          @view.link_to_edit_if_can( clearance.clearence_type, {ctrl: :clearances, object: clearance }),
          clearance.clearence_status.to_s,
          @view.format_date( clearance.date_received),
          @view.format_date( clearance.date_expired),

      ]

    end
  end

  def get_raw_records
    scope = Clearance.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
