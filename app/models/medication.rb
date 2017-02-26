class Medication < ApplicationRecord
  belongs_to :user
  belongs_to :medication_status, optional: true

  has_many :medication_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :medication_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :medication


  def medication_status
    if medication_status_id
      super
    else
      MedicationStatus.default
    end
  end

  def to_s
    medication
  end

  def self.safe_attributes
    [:user_id, :medication, :medication_synonym, :dose, :rxcui, :medication_tty, :description, :date_prescribed, :date_expired,
     :total_refills, :refills_left, :medication_status_id, :medication_description,
     medication_attachments_attributes: [Attachment.safe_attributes]]
  end
end
