class JobAppAttachment < Attachment
  belongs_to :owner, class_name: 'JobApp'
end