class AppointmentCapture < ApplicationRecord
  belongs_to :procedure, optional: true
  belongs_to :disposition, optional: true
  belongs_to :assessment, optional: true
  belongs_to :user
  belongs_to :appointment

  validates_presence_of :user_id, :appointment_id, :note

  def self.safe_attributes
    [
        :user_id, :appointment_id, :assessment_id, :disposition_id, :procedure_id, :note, :date_recorded
    ]
  end

  def assessment
    if assessment_id
      super
    else
      Assessment.default
    end
  end

  def to_s
    assessment
  end

  def disposition
    if disposition_id
      super
    else
      Disposition.default
    end
  end

  def procedure
    if procedure_id
      super
    else
      Procedure.default
    end
  end

end
