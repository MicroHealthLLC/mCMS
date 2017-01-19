class DocumentAttachment < Attachment
  belongs_to :document, foreign_key: :owner_id
  def owner
    self.document
  end
end