class FinancialAttachment < Attachment
  belongs_to :owner, class_name: 'Financial'
end