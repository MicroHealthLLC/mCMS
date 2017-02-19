class AddSkillTypeToOtherSkill < ActiveRecord::Migration[5.0]
  def change
    add_column :other_skills, :skill_type_id, :integer
  end
end
