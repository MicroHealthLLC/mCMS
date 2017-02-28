class MedicalAttachment < Attachment
  belongs_to :owner, class_name: 'Medical'
end