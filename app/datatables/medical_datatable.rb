class MedicalDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
       Medical.name
      Medical.snomed
      Medical.medical_facility
      Medical.date_of_diagnosis
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Medical.name
      Medical.snomed
      Medical.medical_facility
      Medical.date_of_diagnosis
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |medical|
      [

          @view.link_to_edit_if_can( medical.name, {ctrl: :medicals, object: medical }) ,
          medical.snomed.present? ? @view.link_to_edit_if_can( medical.snomed, {ctrl: :medicals, object: medical }) : '' ,
          medical.medical_facility ,
          @view.format_date( medical.date_of_diagnosis) ,
          medical.medical_history_status.to_s,
          medical.medical_history_type.to_s
      ]

    end
  end

  def get_raw_records
    scope = Medical.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
