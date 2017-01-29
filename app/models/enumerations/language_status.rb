class LanguageStatus < Enumeration
  has_many :languages

  OptionName = :enumeration_language_status

  def option_name
    OptionName
  end

  def objects
    Language.where(:status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:status_id => to.id)
  end
end