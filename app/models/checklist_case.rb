class ChecklistCase < ApplicationRecord
  belongs_to :case, foreign_key: :assigned_to_id
  belongs_to :checklist_status_type, optional: true

  belongs_to :checklist_template

  has_many :checklist_notes, foreign_key: :owner_id

  def checklist_status_type
    if checklist_status_type_id
      super
    else
      ChecklistStatusType.default
    end
  end

  def to_s
    self.checklist_template
  end

end
