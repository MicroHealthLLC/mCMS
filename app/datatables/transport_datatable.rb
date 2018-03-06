class TransportDatatable < Abstract

  def sortable_columns
    return @sortable_columns if @sortable_columns
    arr = []
    arr << 'Transport.reason'
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end
    # Declare strings in this format: ModelName.column_name
    arr << %w{
      Enumeration.name
      Transport.location
      Enumeration.name
      Enumeration.name
      Transport.date_time
    }
    @sortable_columns = arr.flatten
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    return @searchable_columns if @searchable_columns
    arr = []
    arr << 'Transport.reason'
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end
    # Declare strings in this format: ModelName.column_name
    arr << %w{
      Enumeration.name
      Transport.location
      Enumeration.name
      Enumeration.name
      Transport.date_time
    }
    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |transport|
      arr = []
      arr << @view.link_to_edit_if_can(transport.reason, {ctrl: :transports, object: transport })
      if @options[:show_case]  == 'true'
        arr << @view.link_to_case( transport.case)
      end
      arr << [
          transport.transport_type.to_s,
          transport.location.to_s,
          transport.transport_location.to_s ,
          transport.transport_status.to_s,
          @view.format_date_time( transport.date_time) ,
      ]
      if @appointment and User.current_user.can?(:manage_roles)
        arr << @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe,
                             @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Transport', id: transport.id ))
      end
      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Transport.include_enumerations.
          where(id: @appointment_links.where(linkable_type: 'Transport').map(&:linkable).compact.map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).transports.include_enumerations
              else
                Transport.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
