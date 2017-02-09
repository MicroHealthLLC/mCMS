class LegalHistoryStatus < Enumeration
  has_many :legals

  OptionName = :enumeration_legal_history_status

  def option_name
    OptionName
  end

  def objects
    Legal.where(:legal_history_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:legal_history_status_id => to.id)
  end
end