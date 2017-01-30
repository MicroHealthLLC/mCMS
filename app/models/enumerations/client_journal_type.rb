class ClientJournalType < Enumeration
  has_many :client_journals

  OptionName = :enumeration_client_journal_type

  def option_name
    OptionName
  end

  def objects
    ClientJournal.where(:client_journal_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:client_journal_type_id => to.id)
  end
end