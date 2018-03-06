class AllergyDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
        Allergy.snomed
      Allergy.allergy_date
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Allergy.snomed
      Allergy.allergy_date
      Enumeration.name
    }
  end

  private

  def data
    records.map do |allergy|
      [

          @view.link_to_edit_if_can( allergy.snomed, {ctrl: :allergies, object: allergy }) ,
          @view.format_date(allergy.allergy_date ),
          "#{allergy.allergy_status}"
      ]

    end
  end

  def get_raw_records
    scope = Allergy.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
