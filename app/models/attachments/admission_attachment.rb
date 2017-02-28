class AdmissionAttachment < Attachment
  belongs_to :owner, class_name: 'Admission'
end