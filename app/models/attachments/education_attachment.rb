class EducationAttachment < Attachment
  belongs_to :owner, class_name: 'Education'
end