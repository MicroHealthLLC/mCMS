class EnrollmentDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
    Enrollment.name
    Enrollment.enrollment_location
      Enumeration.name
      Enumeration.name
      Enrollment.date_start
      Enrollment.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Enrollment.name
      Enrollment.enrollment_location
      Enumeration.name
      Enumeration.name
      Enrollment.date_start
      Enrollment.date_end
    }
  end

  private

  def data
    records.map do |enrollment|
      arr =  [
          @view.link_to_edit_if_can( enrollment.name, {ctrl: :enrollments, object: enrollment }),
          enrollment.enrollment_location.to_s,
          enrollment.enrollment_type.to_s,
          enrollment.enrollment_status.to_s,
          @view.format_date( enrollment.date_start),
          @view.format_date( enrollment.date_end)
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr << @view.link_to( "<i class='fa fa-unlink fa-lg'></i>".html_safe,
                              @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Enrollment', id: enrollment.id ))
      end
      arr

    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Enrollment.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Enrollment').map(&:linkable).compact.map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).enrollments.include_enumerations
              else
                Enrollment.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
