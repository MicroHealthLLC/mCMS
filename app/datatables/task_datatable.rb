class TaskDatatable < Abstract

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = if User.current.can?(:manage_roles)
            ['User.login']
          else
            []
          end
    arr << ['Task.title']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Enumeration.name',
          'Task.date_start',
          'Task.date_completed',
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
    arr << ['Task.title']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr << [ 'Enumeration.name',
             'Enumeration.name',

             'Task.date_start',
             'Task.date_completed',
    ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |task|
      arr = Array.new
      if User.current.can?(:manage_roles)
        arr << task.user.to_s
      end
      arr << @view.link_to_edit_if_can(task.title, {ctrl: :tasks, object: task })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( task.case)
      end
      arr<< [
          task.task_type.to_s ,
          task.task_status_type.to_s ,
          @view.format_date_time( task.date_start ),
          @view.format_date_time( task.date_completed),
          @view.format_date_time( task.date_due)
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr<<  @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Action', id: task.id ))
      end
      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Task.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Task').map(&:linkable).compact.map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).tasks.include_enumerations
              else
                Task.root.include_enumerations
              end
      scope = scope.where('tasks.assigned_to_id = :user OR tasks.for_individual_id = :user', user:  User.current.id)
      scope.filter_status @options[:status_type]
    end

  end

  # ==== Insert 'presenter'-like methods below if necessary
end
