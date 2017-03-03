class AppointmentLink < ApplicationRecord
  belongs_to :user
  belongs_to :appointment

  belongs_to :linkable, polymorphic: true
end
