class WorkerCompensationAttachment < Attachment
  belongs_to :owner, class_name: 'WorkerCompensation'
end