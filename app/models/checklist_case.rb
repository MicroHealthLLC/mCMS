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

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Checklist Case ##{id}", :style => :bold}
    User.current.to_pdf_brief_info(pdf)
    pdf.text "<b>Title: </b> #{ self.checklist_template.title}", :inline_format =>  true
    pdf.text "<b>Type: </b> #{ self.checklist_template.checklist_type}", :inline_format =>  true
    pdf.text "<b>Status: </b> #{checklist_status_type}", :inline_format =>  true
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize( self.checklist_template.description)}", :inline_format =>  true
    self.checklist_template.checklists.each_with_index do |checklist, index|
      checklist_answer = ChecklistAnswer.where(checklist_id: checklist.id,
                                               checklist_case_id: self.try(:id),
                                               user_id: User.current.id).first_or_initialize
      pdf.text "<b>[ #{checklist_answer.status ? 'X' : ' ' } ]</b> #{checklist.description}    #{checklist_answer.due_date}", :inline_format =>  true
    end
  end
end
