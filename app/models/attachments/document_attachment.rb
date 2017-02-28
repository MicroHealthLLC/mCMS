class DocumentAttachment < Attachment
  belongs_to :owner, class_name: 'Document'
end