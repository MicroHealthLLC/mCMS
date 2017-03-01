class ReferralResultAttachment < Attachment
  belongs_to :owner, class_name: 'ReferralResult'
end