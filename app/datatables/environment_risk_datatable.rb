class EnvironmentRiskDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
       EnvironmentRisk.name
      EnvironmentRisk.snomed
      EnvironmentRisk.date_started
      EnvironmentRisk.date_ended
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      EnvironmentRisk.name
      EnvironmentRisk.snomed
      EnvironmentRisk.date_started
      EnvironmentRisk.date_ended
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |environment_risk|
      [
          @view.link_to_edit_if_can( environment_risk.name, {ctrl: :environment_risks, object: environment_risk } ),
          environment_risk.snomed.present? ? @view.link_to_edit_if_can(environment_risk.snomed, {ctrl: :environment_risks, object: environment_risk }) : ''  ,
          environment_risk.date_started ,
          environment_risk.date_ended ,
          environment_risk.environment_status.to_s,
          environment_risk.environment_type.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = EnvironmentRisk.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
