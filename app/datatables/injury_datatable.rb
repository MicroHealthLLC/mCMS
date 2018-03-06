class InjuryDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Injury.injury_name
      Injury.snomed_occupation
      Enumeration.name
      Injury.injury_cause_name
      Injury.snomed_event
      Enumeration.name
      Injury.employer
      Injury.date_of_injury
      Injury.date_resolved
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Injury.injury_name
      Injury.snomed_occupation
      Enumeration.name
      Injury.injury_cause_name
      Injury.snomed_event
      Enumeration.name
      Injury.employer
      Injury.date_of_injury
      Injury.date_resolved
    }
  end

  private

  def data
    records.map do |injury|
      [
          @view.link_to_edit_if_can( injury.injury_name, {ctrl: :injuries, object: injury }) ,
          injury.snomed_occupation.to_s ,
          injury.injury_type.to_s ,
          injury.injury_cause_name.to_s ,
          injury.snomed_event.to_s ,
          injury.injury_status.to_s ,
          injury.employer.to_s ,
          @view.format_date( injury.date_of_injury) ,
          @view.format_date( injury.date_resolved) ,
      ]

    end
  end

  def get_raw_records
    scope = Injury.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
