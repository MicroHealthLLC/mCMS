class Medical < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :medical_history_type, optional: true
  belongs_to :medical_history_status, optional: true

  has_many :medical_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :medical_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def medical_history_type
    if medical_history_type_id
      super
    else
      MedicalHistoryType.default
    end
  end

  def medical_history_status
    if medical_history_status_id
      super
    else
      MedicalHistoryStatus.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :medical_facility, :date_of_diagnosis,
     :medical_history_status_id, :medical_history_type_id, :description,
     medical_attachments_attributes: [Attachment.safe_attributes]

    ]
  end
end
