class AppointmentDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
        Appointment.title
        Enumeration.name
        Enumeration.name
        Appointment.date
    }
    if User.current.can?(:manage_roles)
      @sortable_columns ||= %w{
        CoreDemographic.first_name
        Appointment.title
        Enumeration.name
        Enumeration.name
        Appointment.date
     }
    else
      @sortable_columns ||= %w{

        Appointment.title
        Enumeration.name
        Enumeration.name
        Appointment.date
     }
    end
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    if User.current.can?(:manage_roles)
      @searchable_columns ||= %w{
     CoreDemographic.first_name
        Appointment.title
        Enumeration.name
        Enumeration.name
        Appointment.date
     }
    else
      @searchable_columns ||= %w{

        Appointment.title
        Enumeration.name
        Enumeration.name
        Appointment.date
     }
    end

  end

  private

  def data
    if User.current.can?(:manage_roles)
      records.map do |appointment|
        [
            "<b>#{appointment.user.to_s}<b/>".html_safe,
            @view.link_to_edit_if_can( appointment.title, {ctrl: :appointments, object: appointment }),
            appointment.appointment_type.to_s,
            appointment.appointment_status.to_s,
            appointment.start_time_to_time
        ]
      end
    else
      records.map do |appointment|
        [
            @view.link_to_edit_if_can( appointment.title, {ctrl: :appointments, object: appointment }),
            appointment.appointment_type.to_s,
            appointment.appointment_status.to_s,
            appointment.start_time_to_time
        ]
      end
    end
  end

  def get_raw_records
    scope = Appointment
    scope = case @options[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.opened
            end
    scope.include_enumerations.
        includes(:user=> :core_demographic).
        references(:user=> :core_demographic).
        my_appointments
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
