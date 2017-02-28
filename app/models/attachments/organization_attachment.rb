class OrganizationAttachment < Attachment
  belongs_to :owner, class_name: 'Organization'
end