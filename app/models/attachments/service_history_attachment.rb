class ServiceHistoryAttachment < Attachment
  belongs_to :owner, class_name: 'ServiceHistory'
end