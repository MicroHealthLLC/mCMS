class MilitaryHistoryDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
          MilitaryHistory.text
      Enumeration.name
      Enumeration.name
      MilitaryHistory.date_started
      MilitaryHistory.date_ended
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      MilitaryHistory.text
      Enumeration.name
      Enumeration.name
      MilitaryHistory.date_started
      MilitaryHistory.date_ended
    }
  end

  private

  def data
    records.map do |military_history|
      [
          @view.link_to_edit_if_can( military_history.text, {ctrl: :military_histories, object: military_history }) ,
          military_history.service_type.to_s,
          military_history.service_status.to_s ,
          @view.format_date(military_history.date_started) ,
          @view.format_date(military_history.date_ended) ,
      ]

    end
  end

  def get_raw_records
    scope = MilitaryHistory.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
