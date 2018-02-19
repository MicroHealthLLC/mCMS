class PlanDatatable < AjaxDatatablesRails::Base

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = if User.current.can?(:manage_roles)
            ['User.login']
          else
            []
          end
    arr << ['Plan.name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Enumeration.name',
          'Enumeration.name',
          'Plan.percent_done',
          'Plan.date_start',
          'Plan.date_due',
          'Plan.date_completed',
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
    arr << ['Plan.name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr << [ 'Enumeration.name',
             'Enumeration.name',
             'Enumeration.name',
             'Plan.percent_done',
             'Plan.date_start',
             'Plan.date_due',
             'Plan.date_completed',
    ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |plan|
      arr = Array.new
      if User.current.can?(:manage_roles)
        arr << plan.user.to_s
      end
      arr << @view.link_to_edit_if_can(plan.name, {ctrl: :plans, object: plan })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( plan.case)
      end
      arr<< [
          plan.priority_type.to_s ,
          plan.plan_status.to_s ,
          plan.plan_type.to_s ,
          plan.percent_done || 0 ,
          @view.format_date( plan.date_start ),
          @view.format_date( plan.date_due) ,
          @view.format_date( plan.date_completed)
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr<<  @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Plan', id: plan.id ))
      end
      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Plan.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Plan').map(&:linkable).compact.map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).plans.include_enumerations
              else
                Plan.include_enumerations
              end
      scope.for_manager_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
