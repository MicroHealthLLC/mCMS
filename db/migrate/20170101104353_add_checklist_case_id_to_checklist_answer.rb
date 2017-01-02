class AddChecklistCaseIdToChecklistAnswer < ActiveRecord::Migration[5.0]
  def self.up
    add_column :checklist_answers, :checklist_case_id, :integer
    ChecklistAnswer.all.each do |check_answer|
      t = check_answer.checklist_template
      check_answer.checklist_case_id = ChecklistCase.where(checklist_template_id: t.id).first.try(:id)
      check_answer.save
    end
  end

  def self.down
    remove_column :checklist_answers, :checklist_case_id
  end
end
