class Financial < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :financial_type, optional: true
  belongs_to :financial_status, optional: true
  belongs_to :financial_state, optional: true

  has_many :financial_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :financial_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  def self.enumeration_columns
    [
        ["#{FinancialStatus}", 'financial_status_id']
    ]
  end


  def financial_status
    if financial_status_id
      super
    else
      FinancialStatus.default
    end
  end



  def to_s
    snomed
  end

  def self.safe_attributes
    [:title, :user_id, :financial_status_id, :snomed,
     :description, :date_start, :date_end,
     financial_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Financial ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Financial "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Snomed: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Financial Status: ", " #{financial_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date end: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Financial ##{id} </h2><br/>"
    output<<"<b>Snomed : </b> #{snomed}<br/>"
    output<<"<b>Financial Status : </b> #{financial_status}<br/>"
    output<<"<b>Date start : </b> #{date_start}<br/>"
    output<<"<b>Date end : </b> #{date_end}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

end
