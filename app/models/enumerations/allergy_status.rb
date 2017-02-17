class AllergyStatus < Enumeration
  has_many :allergies

  OptionName = :enumeration_allergy_status

  def option_name
    OptionName
  end

  def objects
    Allergy.where(:allergy_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:allergy_status_id => to.id)
  end
end