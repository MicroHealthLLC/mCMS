class FamilyHistoryDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      FamilyHistory.name
      FamilyHistory.snomed
      FamilyHistory.date_identified
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      FamilyHistory.name
      FamilyHistory.snomed
      FamilyHistory.date_identified
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |family_history|
      [
          @view.link_to_edit_if_can( family_history.name, {ctrl: :family_histories, object: family_history }) ,
          @view.link_to_edit_if_can( family_history.snomed, {ctrl: :family_histories, object: family_history }) ,
          @view.format_date( family_history.date_identified) ,
          family_history.family_status.to_s,
          family_history.family_type.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = FamilyHistory.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
