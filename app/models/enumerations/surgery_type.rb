class SurgeryType < Enumeration
  has_many :surgicals

  OptionName = :enumeration_surgery_type

  def option_name
    OptionName
  end

  def objects
    Surgical.where(:surgery_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:surgery_type_id => to.id)
  end
end