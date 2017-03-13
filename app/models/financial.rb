class Financial < ApplicationRecord
  belongs_to :user
  belongs_to :financial_type, optional: true
  belongs_to :financial_status, optional: true
  belongs_to :financial_state, optional: true

  has_many :financial_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :financial_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :title

  def self.enumeration_columns
    [
        ["#{FinancialType}", 'financial_type_id'],
        ["#{FinancialStatus}", 'financial_status_id']
    ]
  end

  def financial_type
    if financial_type_id
      super
    else
      FinancialType.default
    end
  end

  def financial_status
    if financial_status_id
      super
    else
      FinancialStatus.default
    end
  end

 def financial_state
    if financial_state_id
      super
    else
      FinancialState.default
    end
  end


  def to_s
    title
  end

  def self.safe_attributes
    [:title, :user_id, :financial_type_id, :financial_status_id, :financial_state_id, 
     :description, :estimated_amount, :date_start, :date_end, 
     financial_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Financial ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Financial Type: ", " #{financial_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Financial Status: ", " #{financial_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Estimated Amount: ", " #{estimated_amount}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date end: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
  
end
