class CohabitationType < Enumeration
  has_many :housings

  OptionName = :enumeration_cohabitation_type

  def option_name
    OptionName
  end

  def objects
    Housing.where(:cohabitation_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:cohabitation_type_id => to.id)
  end
end