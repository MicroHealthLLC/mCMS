class Checklist < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :checklist_template
  has_many :checklist_answers, dependent: :destroy

  def self.safe_attributes
    [:id, :description, :user_id, :due_date, :_destroy]
  end

end
