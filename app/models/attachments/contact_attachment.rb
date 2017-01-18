class ContactAttachment < Attachment
  belongs_to :contact, foreign_key: :owner_id
end