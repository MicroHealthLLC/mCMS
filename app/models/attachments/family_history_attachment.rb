class FamilyHistoryAttachment < Attachment
  belongs_to :owner, class_name: 'FamilyHistory'
end