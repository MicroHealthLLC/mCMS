class AdmissionDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Admission.care_family_name
      Admission.date_admitted
      Admission.date_discharged
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Admission.care_family_name
      Admission.date_admitted
      Admission.date_discharged
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |admission|
      [
          @view.link_to_edit_if_can( admission.care_family_name, {ctrl: :admissions, object: admission }),
          @view.format_date( admission.date_admitted),
          @view.format_date( admission.date_discharged),
          "#{admission.admission_status}",
          "#{admission.admission_type}"
      ]



    end
  end

  def get_raw_records
    scope = Admission.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
