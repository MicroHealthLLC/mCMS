class EducationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Education.date_recieved
      Education.date_expired
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Enumeration.name
      Enumeration.name
      Education.date_recieved
      Education.date_expired
    }
  end

  private

  def data
    records.map do |education|
      [

          @view.link_to_edit_if_can(  education.education_type, {ctrl: :educations, object:  education }),
          education.education_status.to_s,
          @view.format_date( education.date_recieved),
          @view.format_date( education.date_expired),
      ]

    end
  end

  def get_raw_records
    scope = Education.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
