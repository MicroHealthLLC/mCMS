class OtherHistory < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :other_history_type, optional: true
  belongs_to :other_history_status, optional: true

  has_many :other_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :other_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{OtherHistoryType}", 'other_history_type_id'],
        ["#{OtherHistoryStatus}", 'other_history_status_id']
    ]
  end

  def other_history_type
    if other_history_type_id
      super
    else
      OtherHistoryType.default
    end
  end

  def other_history_status
    if other_history_status_id
      super
    else
      OtherHistoryStatus.default
    end
  end

  def to_s
    name
  end
  
  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :date_resolved,
     :other_history_status_id, :other_history_type_id, :description,
     other_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Other History ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Other History "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Icdcm Code: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Other History Type: ", " #{other_history_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Other History Status: ", " #{other_history_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Identified: ", " #{date_identified}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date resolved: ", " #{date_resolved}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Other History ##{id} </h2><br/>"
    output<<"<b>Name: </b> #{name}<br/>"
    output<<"<b>Icdcm Code : </b> #{icdcm_code}<br/>"
    output<<"<b>Other History Type : </b> #{other_history_type}<br/>"
    output<<"<b>Other History Status : </b> #{other_history_status}<br/>"
    output<<"<b>Date Identified: </b> #{date_identified}<br/>"
    output<<"<b>Date resolved: </b> #{date_resolved}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end
end
