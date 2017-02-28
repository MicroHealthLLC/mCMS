class SurgicalAttachment < Attachment
  belongs_to :owner, class_name: 'Surgical'
end