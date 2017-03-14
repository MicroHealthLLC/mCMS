class Resume < ApplicationRecord
  belongs_to :user
  belongs_to :resume_type, optional: true
  belongs_to :resume_status, optional: true

  has_many :resume_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :resume_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :user_id, :title

  def to_s
    title
  end

  def self.enumeration_columns
    [
        ["#{ResumeStatus}", 'resume_status_id'],
        ["#{ResumeType}", 'resume_type_id']
    ]
  end

  def resume_type
    if resume_type_id
      super
    else
      ResumeType.default
    end
  end

  def resume_status
    if resume_status_id
      super
    else
      ResumeStatus.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :title, :date, :resume_type_id,
        :resume_status_id, :note,
        resume_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Resume ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Resume "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Resume Type: ", " #{resume_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Resume Status: ", " #{resume_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date: ", " #{date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])

  end

end
