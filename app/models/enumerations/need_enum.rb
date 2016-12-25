class NeedEnum < Enumeration
  has_many :needs

  OptionName = :enumeration_need

  def option_name
    OptionName
  end

  def objects
    Need.where(:need_enum_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:need_enum_id => to.id)
  end
end