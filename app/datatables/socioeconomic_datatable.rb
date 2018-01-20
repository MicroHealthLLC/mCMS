class SocioeconomicDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Socioeconomic.name
      Socioeconomic.snomed
      Socioeconomic.date_identified
      Socioeconomic.date_resolved
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Socioeconomic.name
      Socioeconomic.snomed
      Socioeconomic.date_identified
      Socioeconomic.date_resolved
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |socioeconomic|
      [
          @view.link_to_edit_if_can( socioeconomic.name, {ctrl: :socioeconomics, object: socioeconomic } ),
          socioeconomic.snomed.present? ? @view.link_to_edit_if_can(socioeconomic.snomed, {ctrl: :socioeconomics, object: socioeconomic }) : '' ,
          @view.format_date( socioeconomic.date_identified) ,
          @view.format_date( socioeconomic.date_resolved) ,
          socioeconomic.socioeconomic_status.to_s,
          socioeconomic.socioeconomic_type.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = Socioeconomic.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
