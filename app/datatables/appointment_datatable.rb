class AppointmentDatatable < AjaxDatatablesRails::Base

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = if User.current.can?(:manage_roles)
            ['User.login']
          else
            []
          end
    arr << ['Appointment.title']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [  'Enumeration.name',
           'Enumeration.name',
           'Appointment.date'
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
    arr << ['Appointment.title']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [  'Enumeration.name',
           'Enumeration.name',
           'Appointment.date'
        ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |appointment|
      arr = Array.new
      if User.current.can?(:manage_roles)
        arr << appointment.user.to_s
      end
      arr << @view.link_to_edit_if_can(appointment.title, {ctrl: :appointments, object: appointment })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( appointment.case)
      end
      arr<< [
          appointment.appointment_type.to_s,
          appointment.appointment_status.to_s,
          appointment.start_time_to_time
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr<<  @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Appointment', id: need.id ))
      end
      arr.flatten

    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Appointment.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Appointment').map(&:linkable).map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).appointments.include_enumerations
              else
                Appointment.my_appointments.include_enumerations
              end
      scope.filter_status @options[:status_type]
    end
  end

# ==== Insert 'presenter'-like methods below if necessary
end
