class ClearanceAttachment < Attachment
  belongs_to :clearance, foreign_key: :owner_id
end