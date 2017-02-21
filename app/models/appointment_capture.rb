class AppointmentCapture < ApplicationRecord
  belongs_to :assessment, optional: true
  belongs_to :user
  belongs_to :appointment
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'

  validates_presence_of :user_id, :appointment_id, :note

  def self.safe_attributes
    [
        :user_id, :appointment_id, :assessment_id, :note, :date_recorded, :icdcm_code_id
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

end
