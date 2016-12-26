class AppointmentNote < Note
  belongs_to :appointment, foreign_key: :owner_id, class_name: 'Appointment'

  def object
    appointment
  end

end
