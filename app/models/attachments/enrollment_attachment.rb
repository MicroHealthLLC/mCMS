class EnrollmentAttachment < Attachment
  belongs_to :owner, class_name: 'Enrollment'
end