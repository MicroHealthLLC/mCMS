class LaboratoryExaminationDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      LaboratoryExamination.snomed
      LaboratoryExamination.facility
      LaboratoryExamination.date
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      LaboratoryExamination.snomed
      LaboratoryExamination.facility
      LaboratoryExamination.date
      Enumeration.name
    }
  end

  private

  def data
    records.map do |laboratory_examination|
      [
          @view.link_to_edit_if_can( laboratory_examination.snomed, {ctrl: :laboratory_examinations, object: laboratory_examination }) ,
          laboratory_examination.facility ,
          @view.format_date( laboratory_examination.date) ,
          laboratory_examination.laboratory_result_status.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = LaboratoryExamination.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
