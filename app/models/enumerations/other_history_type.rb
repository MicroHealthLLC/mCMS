class OtherHistoryType < Enumeration
  has_many :other_histories

  OptionName = :enumeration_other_history_type

  def option_name
    OptionName
  end

  def objects
    OtherHistory.where(:other_history_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:other_history_type_id => to.id)
  end
end