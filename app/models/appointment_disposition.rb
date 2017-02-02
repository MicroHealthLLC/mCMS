class AppointmentDisposition < ApplicationRecord
  belongs_to :disposition, optional: true
  belongs_to :user
  belongs_to :appointment

  validates_presence_of :user_id, :appointment_id, :note

  def self.safe_attributes
    [
        :user_id, :appointment_id, :disposition_id, :note, :date_recorded
    ]
  end


  def to_s
    disposition
  end

  def disposition
    if disposition_id
      super
    else
      Disposition.default
    end
  end

end
