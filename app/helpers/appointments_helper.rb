module AppointmentsHelper
  def appointment_back_url appointment
    appointment.related_to_id ? appointment.case : appointments_path
  end

  def date_time_form(datetime)
    datetime.strftime("%Y-%m-%d %I:%M %p") if datetime
  end

end
