class SurgeryStatus < Enumeration
  has_many :surgicals

  OptionName = :enumeration_surgery_status

  def option_name
    OptionName
  end

  def objects
    Surgical.where(:surgery_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:surgery_status_id => to.id)
  end
end