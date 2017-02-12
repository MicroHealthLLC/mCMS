class ChecklistType < Enumeration
  has_many :checklist_templates

  OptionName = :enumeration_checklist_type

  def option_name
    OptionName
  end

  def objects
    ChecklistTemplate.where(:checklist_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:checklist_type_id => to.id)
  end
end