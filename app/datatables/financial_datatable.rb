class FinancialDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Financial.snomed
      Enumeration.name
      Financial.date_start
      Financial.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
        Financial.snomed
      Enumeration.name
      Financial.date_start
      Financial.date_end
    }
  end

  private

  def data
    records.map do |financial|
      [
          @view.link_to_edit_if_can( financial.snomed.presence, {ctrl: :financials, object: financial } ),
          financial.financial_status.to_s ,
          @view.format_date(financial.date_start) ,
          @view.format_date(financial.date_end) ,
      ]

    end
  end

  def get_raw_records
    scope = Financial.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
