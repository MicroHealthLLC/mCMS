class DailyLivingDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
        DailyLiving.snomed
      Enumeration.name
      Enumeration.name
      DailyLiving.date_start
      DailyLiving.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      DailyLiving.snomed
      Enumeration.name
      Enumeration.name
      DailyLiving.date_start
      DailyLiving.date_end
    }
  end

  private

  def data
    records.map do |daily_living|
      [
          @view.link_to_edit_if_can( daily_living.snomed,{ctrl: :daily_livings, object: daily_living })  ,
          daily_living.daily_living_status.to_s ,
          @view.format_date( daily_living.date_start) ,
          @view.format_date( daily_living.date_end) ,
      ]

    end
  end

  def get_raw_records
    scope = DailyLiving.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
