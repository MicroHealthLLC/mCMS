class LanguageDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Language.snomed
      Enumeration.name
      Enumeration.name
      Language.updated_at
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Language.snomed
      Enumeration.name
      Enumeration.name
      Language.updated_at
    }
  end

  private

  def data
    records.map do |language|
      [
          @view. link_to_edit_if_can(language.language_type, {ctrl: :languages, object: language }),
          language.language_status.to_s,
          language.proficiency_type.to_s,
          @view.format_date( language.updated_at)
      ]

    end
  end

  def get_raw_records
    scope = Language.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
