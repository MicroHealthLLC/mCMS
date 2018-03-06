class OtherHistoryDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
     OtherHistory.name
      Icd10datum.name
      OtherHistory.date_identified
      OtherHistory.date_resolved
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      OtherHistory.name
      Icd10datum.name
      OtherHistory.date_identified
      OtherHistory.date_resolved
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |other_history|
      [
          @view.link_to_edit_if_can( other_history.name, {ctrl: :other_histories, object: other_history }) ,
          other_history.icdcm_code.to_s ,
          @view.format_date( other_history.date_identified) ,
          @view.format_date( other_history.date_resolved) ,
          other_history.other_history_status.to_s ,
          other_history.other_history_type.to_s
      ]

    end
  end

  def get_raw_records
    scope = OtherHistory.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
