class LegalAttachment < Attachment
  belongs_to :owner, class_name: 'Legal'
end