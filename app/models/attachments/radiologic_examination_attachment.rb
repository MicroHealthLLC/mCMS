class RadiologicExaminationAttachment < Attachment
  belongs_to :owner, class_name: 'RadiologicExamination'
end