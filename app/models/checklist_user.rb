class ChecklistUser < ApplicationRecord
  belongs_to :user, foreign_key: :assigned_to_id
  belongs_to :checklist_template

  def self.safe_attributes
    [ :assigned_to_id, :checklist_template_id]
  end
end
