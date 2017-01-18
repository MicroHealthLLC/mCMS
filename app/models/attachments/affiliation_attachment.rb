class AffiliationAttachment < Attachment
  belongs_to :affiliation, foreign_key: :owner_id
end