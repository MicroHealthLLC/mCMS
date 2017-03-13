class Legal < ApplicationRecord
  belongs_to :user
  belongs_to :legal_history_type, optional: true
  belongs_to :legal_history_status, optional: true

  has_many :legal_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :legal_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :title

  def self.enumeration_columns
    [
        ["#{LegalHistoryType}", 'legal_history_type_id'],
        ["#{LegalHistoryStatus}", 'legal_history_status_id']
    ]
  end

  def legal_history_type
    if legal_history_type_id
      super
    else
      LegalHistoryType.default
    end
  end

  def legal_history_status
    if legal_history_status_id
      super
    else
      LegalHistoryStatus.default
    end
  end


  def to_s
    title
  end

  def self.safe_attributes
    [:user_id, :title, :legal_history_id, :legal_history_status_id, :description, :date_start,
     :date_end, legal_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Legal ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Legal Status: ", " #{legal_history_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Legal Type: ", " #{legal_history_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date end: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
  
end
