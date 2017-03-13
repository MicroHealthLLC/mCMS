class ChecklistCase < ApplicationRecord
  belongs_to :case, foreign_key: :assigned_to_id
  belongs_to :checklist_status_type, optional: true

  belongs_to :checklist_template

  has_many :checklist_notes, foreign_key: :owner_id

  def self.include_enumerations
    includes(:checklist_status_type).references(:checklist_status_type)
  end


  def self.enumeration_columns
    [
        ["#{ChecklistStatusType}", 'checklist_status_type_id']
    ]
  end

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

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Checklist Case ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    User.current.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Checklist Case "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Title: ", " #{ self.checklist_template.title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Type: ", " #{ self.checklist_template.checklist_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Status: ", " #{checklist_status_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize( self.checklist_template.description)}"]], :column_widths => [ 150, 373])
    self.checklist_template.checklists.each_with_index do |checklist, index|
      checklist_answer = ChecklistAnswer.where(checklist_id: checklist.id,
                                               checklist_case_id: self.try(:id),
                                               user_id: User.current.id).first_or_initialize
      pdf.table([[ "[ #{checklist_answer.status ? 'X' : ' ' } ]", " #{checklist.description}    #{checklist_answer.due_date}"]], :column_widths => [ 150, 373])
    end
  end
end
