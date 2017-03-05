class AppointmentLink < ApplicationRecord
  belongs_to :user
  belongs_to :appointment

  belongs_to :linkable, polymorphic: true

  def self.create_or_update(appointment, type, id)
    a = AppointmentLink.where( appointment_id: appointment.id,
                               linkable_id: id,
                               linkable_type: type
    ).first_or_initialize
    a.user_id = User.current.id
    a.save
    a
  end
end
