class ClientJournalAttachment < Attachment
  belongs_to :owner, class_name: 'ClientJournal'
end