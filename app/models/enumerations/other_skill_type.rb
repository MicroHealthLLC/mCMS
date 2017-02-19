class OtherSkillType < Enumeration
  has_many :other_skills

  OptionName = :enumeration_skill_status

  def option_name
    OptionName
  end

  def objects
    OtherSkill.where(:skill_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:skill_type_id => to.id)
  end
end