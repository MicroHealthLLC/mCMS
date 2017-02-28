class JobApplicationAttachment < Attachment
  belongs_to :owner, class_name: 'JobApplication'
end