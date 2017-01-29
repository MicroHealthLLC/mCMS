class ClearenceStatus < Enumeration
  has_many :clearances

  OptionName = :enumeration_clearence_status

  def option_name
    OptionName
  end

  def objects
    Clearance.where(:status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:status_id => to.id)
  end
end