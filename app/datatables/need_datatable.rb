class NeedDatatable < AjaxDatatablesRails::Base

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = if User.current.can?(:manage_roles)
            ['User.login']
          else
            []
          end
    arr << ['Enumeration.name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Enumeration.name',
          'Need.percent_done',
          'Need.date_identified',
          'Need.date_due',
          'Need.date_completed',
        ]

    @sortable_columns = arr.flatten
  end

  def searchable_columns

    return @searchable_columns if @searchable_columns
    # Declare strings in this format: ModelName.column_name
    arr = if User.current.can?(:manage_roles)
            ['User.login']
          else
            []
          end
    arr << ['Enumeration.name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr << [ 'Enumeration.name',
             'Enumeration.name',
             'Need.percent_done',
             'Need.date_identified',
             'Need.date_due',
             'Need.date_completed',
    ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |need|
      arr = Array.new
      if User.current.can?(:manage_roles)
        arr << need.user.to_s
      end
      arr << @view.link_to_edit_if_can(need.need_enum, {ctrl: :needs, object: need })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( need.case)
      end
      arr<< [
          need.priority_type.to_s ,
          need.need_status.to_s ,
          need.percent_done || 0 ,
          @view.format_date( need.date_identified ),
          @view.format_date( need.date_due) ,
          @view.format_date( need.date_completed)
      ]
      arr.flatten
    end
  end

  def get_raw_records
    scope = if @options[:case_id]
              Case.find(@options[:case_id]).needs.include_enumerations
            else
              Need.include_enumerations
            end
    scope.for_manager_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
