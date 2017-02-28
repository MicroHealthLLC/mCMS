class ClearanceAttachment < Attachment
  belongs_to :owner, class_name: 'Clearance'
end