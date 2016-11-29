module AppointmentsHelper
  def back_url appointment
    appointment.related_to_id ? appointment.case : appointments_path
  end
end
