class AppointmentAttachment < Attachment
  belongs_to :owner, class_name: 'Appointment'
end