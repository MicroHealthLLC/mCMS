module AppointmentsHelper
  def appointment_back_url appointment
    appointment.related_to_id ? appointment.case : appointments_path
  end
end
