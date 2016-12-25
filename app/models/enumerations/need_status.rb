class NeedStatus < Enumeration
  has_many :needs

  OptionName = :enumeration_need_status

  def option_name
    OptionName
  end

  def objects
    Need.where(:need_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:need_status_id => to.id)
  end
end