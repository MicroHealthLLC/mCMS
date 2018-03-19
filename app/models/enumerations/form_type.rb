class FormType < Enumeration
  has_many :formulars

  OptionName = :enumeration_form_type

  def option_name
    OptionName
  end

  def objects
    Formular.where(:form_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:form_type_id => to.id)
  end
end