class HousingDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
       BehavioralRisk.name
      BehavioralRisk.snomed
      BehavioralRisk.date_started
      BehavioralRisk.date_ended
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      BehavioralRisk.name
      BehavioralRisk.snomed
      BehavioralRisk.date_started
      BehavioralRisk.date_ended
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |behavioral_risk|
      [
          @view.link_to_edit_if_can( behavioral_risk.name, {ctrl: :behavioral_risks, object: behavioral_risk }) ,
          @view.link_to( behavioral_risk.snomed, behavioral_risk),
          @view.format_date( behavioral_risk.date_started) ,
          @view.format_date(  behavioral_risk.date_ended) ,
          behavioral_risk.behavioral_risk_status ,
          behavioral_risk.behavioral_risk_type ,
      ]

    end
  end

  def get_raw_records
    scope = Housing.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
