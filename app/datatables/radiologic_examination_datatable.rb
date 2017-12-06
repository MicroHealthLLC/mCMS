class RadiologicExaminationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      RadiologicExamination.snomed
      RadiologicExamination.facility
      RadiologicExamination.date
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      RadiologicExamination.snomed
      RadiologicExamination.facility
      RadiologicExamination.date
      Enumeration.name
    }
  end

  private

  def data
    records.map do |radiologic_examination|
      [
          @view.link_to_edit_if_can( radiologic_examination.snomed, {ctrl: :radiologic_examinations, object: radiologic_examination }) ,
          radiologic_examination.facility ,
          @view.format_date( radiologic_examination.date) ,
          radiologic_examination.radiologic_result_status.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = RadiologicExamination.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
