class TeleconsultDatatable < Abstract

  def sortable_columns
    return @sortable_columns if @sortable_columns
    arr = []
    arr << 'Enumeration.name'
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end
    # Declare strings in this format: ModelName.column_name
    arr << %w{
      Enumeration.name
      Enumeration.name
      Teleconsult.date
      Teleconsult.time
    }
    @sortable_columns = arr.flatten
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    return @searchable_columns if @searchable_columns
    arr = []
    arr << 'Enumeration.name'
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end
    # Declare strings in this format: ModelName.column_name
    arr << %w{
      Enumeration.name
      Enumeration.name
      Teleconsult.date
      Teleconsult.time
    }
    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |teleconsult|
      arr = []
      arr << @view.link_to_edit_if_can(teleconsult.contact_method, {ctrl: :teleconsults, object: teleconsult })
      if @options[:show_case]  == 'true'
        arr << @view.link_to_case( teleconsult.case)
      end
      arr << [
          teleconsult.contact_type.to_s ,
          teleconsult.consult_status.to_s ,
          @view.format_date( teleconsult.date) ,
          teleconsult.time ]
      if @appointment and User.current_user.can?(:manage_roles)
        arr << @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe,
                             @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Teleconsult', id: teleconsult.id ))
      end
      arr.flatten

    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Teleconsult.include_enumerations.
          where(id: @appointment_links.where(linkable_type: 'Teleconsult').map(&:linkable).compact.map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).teleconsults.include_enumerations
              else
                Teleconsult.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
