class DeploymentHistoryAttachment < Attachment
  belongs_to :owner, class_name: 'DeploymentHistory'
end