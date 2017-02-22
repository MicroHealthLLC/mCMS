class Injury < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :injury_cause, class_name: 'Icd10datum'
  belongs_to :injury_type, optional: true
  belongs_to :injury_status, optional: true

  has_many :injury_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :injury_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  def injury_type
    if injury_type_id
      super
    else
      InjuryType.default
    end
  end

  def injury_status
    if injury_status_id
      super
    else
      InjuryStatus.default
    end
  end


  def to_s
    icdcm_code.to_s
  end

  def self.safe_attributes
    [
        :user_id, :icdcm_code_id, :injury_type_id, :injury_cause_id,
        :injury_status_id, :employer, :date_of_injury, :date_resolved, :description,
        injury_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
  
end
