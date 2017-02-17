class Surgical < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :surgery_type, optional: true
  belongs_to :surgery_status, optional: true

  has_many :surgical_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :surgical_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :icdcm_code_id

  def surgery_type
    if surgery_type_id
      super
    else
      SurgeryType.default
    end
  end

  def surgery_status
    if surgery_status_id
      super
    else
      SurgeryStatus.default
    end
  end

  def to_s
    icdcm_code
  end

  def self.safe_attributes
    [:icdcm_code_id, :user_id, :medical_facility,
     :surgery_status_id, :surgery_type_id,
     :description,
     surgical_attachments_attributes: [Attachment.safe_attributes]]
  end
end
