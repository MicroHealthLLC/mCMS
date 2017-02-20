class BehavioralRisk < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :behavioral_risk_type, optional: true
  belongs_to :behavioral_risk_status, optional: true

  has_many :behavioral_risk_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :behavioral_risk_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def behavioral_risk_type
    if behavioral_risk_type_id
      super
    else
      BehavioralRiskType.default
    end
  end

  def behavioral_risk_status
    if behavioral_risk_status_id
      super
    else
      BehavioralRiskStatus.default
    end
  end


  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_started, :date_ended,
     :behavioral_risk_status_id, :behavioral_risk_type_id, :description,
     behavioral_risk_attachments_attributes: [Attachment.safe_attributes]]
  end
end
