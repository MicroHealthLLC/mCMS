class InstallationName < Enumeration
  has_many :units

  OptionName = :enumeration_installation_name

  def option_name
    OptionName
  end

  def objects
    Unit.where(:installation_name_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:installation_name_id => to.id)
  end
end