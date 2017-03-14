class ResumeAttachment < Attachment
  belongs_to :owner, class_name: 'Resume'
end