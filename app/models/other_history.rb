class OtherHistory < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :other_history_type, optional: true
  belongs_to :other_history_status, optional: true

  has_many :other_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :other_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def other_history_type
    if other_history_type_id
      super
    else
      OtherHistoryType.default
    end
  end

  def other_history_status
    if other_history_status_id
      super
    else
      OtherHistoryStatus.default
    end
  end

  def to_s
    name
  end
  
  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :date_resolved,
     :other_history_status_id, :other_history_type_id, :description,
     other_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
