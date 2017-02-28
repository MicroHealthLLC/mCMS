class UserInsuranceAttachment < Attachment
  belongs_to :owner, class_name: 'UserInsurance'
end