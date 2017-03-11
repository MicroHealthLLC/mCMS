class BillingAttachment < Attachment
  belongs_to :owner, class_name: 'Billing'
end