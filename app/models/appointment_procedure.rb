class AppointmentProcedure < ApplicationRecord
  belongs_to :procedure, optional: true
  belongs_to :user
  belongs_to :appointment

  validates_presence_of :user_id, :appointment_id, :note

  def self.safe_attributes
    [
        :user_id, :appointment_id, :procedure_id, :note, :date_recorded
    ]
  end

  def to_s
    procedure
  end


  def procedure
    if procedure_id
      super
    else
      Procedure.default
    end
  end

end
