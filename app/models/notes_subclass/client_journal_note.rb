class ClientJournalNote < Note
  belongs_to :client_journal, foreign_key: :owner_id

  def object
    client_journal
  end
end