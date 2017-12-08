class PositionDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Position.title
      Enumeration.name
      Enumeration.name
      Position.date_start
      Position.date_end
      Enumeration.name
      Enumeration.name
      Position.estimated_monthly_amount
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Position.title
      Enumeration.name
      Enumeration.name
      Position.date_start
      Position.date_end
      Enumeration.name
      Enumeration.name
      Position.estimated_monthly_amount
    }
  end

  private

  def data
    records.map do |position|
      [
          @view.link_to_edit_if_can(position.title, {ctrl: :positions, object: position } ),
          position.occupation.to_s ,
          position.location_type.to_s ,
          @view.format_date( position.date_start) ,
          @view.format_date( position.date_end) ,
          position.employment_type.to_s ,
          position.position_status.to_s ,
          position.estimated_monthly_amount ,
      ]

    end
  end

  def get_raw_records
    scope = Position.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
