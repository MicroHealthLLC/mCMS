class DailyLivingType < Enumeration
  has_many :daily_livings

  OptionName = :enumeration_daily_living_type

  def option_name
    OptionName
  end

  def objects
    DailyLiving.where(:daily_living_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:daily_living_type_id => to.id)
  end
end