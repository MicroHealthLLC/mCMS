class ReferralResult < ApplicationRecord
  belongs_to :user
  belongs_to :referral
  has_many :referral_result_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :referral_result_attachments, reject_if: :all_blank, allow_destroy: true

  def to_s
    result.to_s[0..15]
  end

  def self.safe_attributes
    [
        :user_id, :referral_id, :result_date, :result,
        referral_result_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
