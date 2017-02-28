class SkillAttachment < Attachment
  belongs_to :owner, class_name: 'OtherSkill'
end