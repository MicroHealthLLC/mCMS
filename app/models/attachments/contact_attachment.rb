class ContactAttachment < Attachment
  belongs_to :owner, class_name: 'Contact'
end