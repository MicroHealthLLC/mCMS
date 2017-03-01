class Referral < ApplicationRecord
  belongs_to :user
  belongs_to :case
  belongs_to :referral_type, optional: true
  belongs_to :referral_status, optional: true
  belongs_to :referred_by, class_name: 'User', optional: true
  belongs_to :referred_to, class_name: 'ClientOrganization', optional: true

  has_many :referral_relation_children, class_name: 'ReferralRelation', foreign_key: :referral_child_id
  has_many :referral_children, class_name: 'Referral', through: :referral_relation_children

  has_many :referral_relation_parents, class_name: 'ReferralRelation', foreign_key: :referral_parent_id
  has_many :referral_parents, class_name: 'Referral', through: :referral_relation_parents


  has_many :referral_notes, foreign_key: :owner_id, dependent: :destroy
  has_many :referral_results, dependent: :destroy

  has_many :referral_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :referral_attachments, reject_if: :all_blank, allow_destroy: true

  
  validates_presence_of :user_id, :title

  def referral_type
    if referral_type_id
      super
    else
      ReferralType.default
    end
  end

  def referral_status
    if referral_status_id
      super
    else
      ReferralStatus.default
    end
  end

  def available_referrals
    (self.case.try(:referrals) || []) - [self] - [referral_parents]
  end

  def to_s
    title
  end

  def self.safe_attributes
    [
        :user_id, :title, :referral_type_id, :referral_date, :referral_appointment, :case_id,
        :referral_status_id, :referred_by_id, :referred_to_id, :referral_reason,
        referral_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
