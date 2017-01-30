class ClientJournalAttachment < Attachment
  belongs_to :client_journal, foreign_key: :owner_id
end