class SignatureAttachment < Attachment
  belongs_to :owner, class_name: 'Jsignature'
end