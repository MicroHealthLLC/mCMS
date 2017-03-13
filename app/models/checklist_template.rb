class ChecklistTemplate < ApplicationRecord
  belongs_to :user
  belongs_to :checklist_status_type, optional: true
  belongs_to :checklist_type, optional: true

  has_many :checklists, dependent: :destroy
  has_many :checklist_users, dependent: :destroy
  has_many :checklist_cases, dependent: :destroy
  accepts_nested_attributes_for :checklists, reject_if: :all_blank, allow_destroy: true

  has_many :checklist_answers, dependent: :destroy

  belongs_to :case, optional: true, foreign_key: :related_to_id

  scope :not_related, -> {where(related_to_id: nil)}

  validates_presence_of :title


  def self.enumeration_columns
    [
        ["#{ChecklistStatusType}", 'checklist_status_type_id'],
        ["#{ChecklistType}", 'checklist_type_id']
    ]
  end

  def checklist_status_type
    if checklist_status_type_id
      super
    else
      ChecklistStatusType.default
    end
  end

  def checklist_type
    if checklist_type_id
      super
    else
      ChecklistType.default
    end
  end

  def self.safe_attributes
    [:title, :description, :user_id, :checklist_status_type_id, :related_to_id, :related_to_type, :checklist_type, checklists_attributes: [Checklist.safe_attributes]]
  end

  def to_s
    title
  end

 def self.safe_attributes_with_save
    [checklist_answers_attributes: [ChecklistAnswer.safe_attributes]]
 end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Checklist ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    User.current.to_pdf_brief_info(pdf) if show_user

    pdf.table([[" Checklist Template "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Type: ", " #{checklist_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    self.checklists.each_with_index do |checklist, index|
      checklist_answer = ChecklistAnswer.where(checklist_id: checklist.id, user_id: User.current.id).first_or_initialize
      pdf.table([[ "[ #{checklist_answer.status ? 'X' : ' ' } ]", " #{checklist.description}    #{checklist_answer.due_date}"]], :column_widths => [ 150, 373])
    end
  end
end
