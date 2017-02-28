class TaskAttachment < Attachment
  belongs_to :owner, class_name: 'Task'

end