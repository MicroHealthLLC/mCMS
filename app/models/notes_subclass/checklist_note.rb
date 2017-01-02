class ChecklistNote < Note
  belongs_to :checklist_case, foreign_key: :owner_id

  def object
    checklist_case
  end
end