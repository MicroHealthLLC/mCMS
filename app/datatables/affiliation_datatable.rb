class AffiliationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Affiliation.name
      Enumeration.name
      Enumeration.name
      Affiliation.date_start
      Affiliation.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Affiliation.name
      Enumeration.name
      Enumeration.name
      Affiliation.date_start
      Affiliation.date_end
    }
  end

  private

  def data
    records.map do |affiliation|
      [
          @view.link_to_edit_if_can(affiliation.name, {ctrl: :affiliations, object: affiliation }),
          affiliation.affiliation_type.to_s ,
          affiliation.affiliation_status.to_s ,
          @view.format_date( affiliation.date_start ),
          @view.format_date( affiliation.date_end ),
      ]



    end
  end

  def get_raw_records
    scope = Affiliation.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
