class GoalDatatable < AjaxDatatablesRails::Base

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = if User.current.can?(:manage_roles)
            ['User.login']
          else
            []
          end
    arr << ['Goal.name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Enumeration.name',
          'Enumeration.name',
          'Goal.percent_done',
          'Goal.date_start',
          'Goal.date_due',
          'Goal.date_completed',
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
    arr << ['Goal.name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr << [ 'Enumeration.name',
             'Enumeration.name',
             'Enumeration.name',
             'Goal.percent_done',
             'Goal.date_start',
             'Goal.date_due',
             'Goal.date_completed',
    ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |goal|
      arr = Array.new
      if User.current.can?(:manage_roles)
        arr << goal.user.to_s
      end
      arr << @view.link_to_edit_if_can(goal.name, {ctrl: :goals, object: goal })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( goal.case)
      end
      arr<< [
          goal.priority_type.to_s ,
          goal.goal_status.to_s ,
          goal.goal_type.to_s ,
          goal.percent_done || 0 ,
          @view.format_date( goal.date_start ),
          @view.format_date( goal.date_due) ,
          @view.format_date( goal.date_completed)
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr<<  @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Goal', id: goal.id ))
      end
      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Goal.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Goal').map(&:linkable).map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).goals.include_enumerations
              else
                Goal.root.include_enumerations
              end
      scope.for_manager_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
