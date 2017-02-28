class ReferralAttachment < Attachment
  belongs_to :owner, class_name: 'Referral'
end