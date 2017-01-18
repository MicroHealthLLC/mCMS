class CertificationAttachment < Attachment
  belongs_to :certification, foreign_key: :owner_id
end