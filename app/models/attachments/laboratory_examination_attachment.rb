class LaboratoryExaminationAttachment < Attachment
  belongs_to :owner, class_name: 'LaboratoryExamination'
end