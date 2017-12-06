class LegalDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Legal.title
      Enumeration.name
      Enumeration.name
      Legal.date_start
      Legal.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Legal.title
      Enumeration.name
      Enumeration.name
      Legal.date_start
      Legal.date_end
    }
  end

  private

  def data
    records.map do |legal|
      [
          @view.link_to_edit_if_can( legal.title, {ctrl: :legals, object: legal }) ,
          legal.legal_history_type.to_s ,
          legal.legal_history_status.to_s ,
          @view.format_date( legal.date_start ),
          @view.format_date( legal.date_end ),
      ]

    end
  end

  def get_raw_records
    scope = Legal.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
