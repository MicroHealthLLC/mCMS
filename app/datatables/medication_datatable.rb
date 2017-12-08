class MedicationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Medication.medication_synonym
      Medication.dose
      Medication.description
      Medication.date_prescribed
      Medication.date_expired
      Medication.total_refills
      Medication.refills_left
      Medication.medication_status
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Medication.medication_synonym
      Medication.dose
      Medication.description
      Medication.date_prescribed
      Medication.date_expired
      Medication.total_refills
      Medication.refills_left
      Enumeration.name
    }
  end

  private

  def data
    records.map do |medication|
      [

          @view.link_to_edit_if_can( medication.medication_synonym, {ctrl: :medications, object: medication }) ,
          medication.dose ,
          medication.description ,
          @view.format_date(medication.date_prescribed) ,
          @view.format_date(medication.date_expired ),
          medication.total_refills ,
          medication.refills_left ,
          medication.medication_status.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = Medication.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
