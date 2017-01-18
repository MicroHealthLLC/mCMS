class AppointmentAttachment < Attachment
  belongs_to :appointment, foreign_key: :owner_id

  def owner
    self.appointment
  end
end