class Teleconsult < ApplicationRecord
  belongs_to :user
  belongs_to :case

  belongs_to :contact_method, optional: true
  belongs_to :consult_status, optional: true
  belongs_to :contact_type, optional: true

  has_many :appointment_links, as: :linkable

  has_many :consult_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :consult_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :user_id, :note, :case_id, :contact_method_id

  def self.safe_attributes
    [:user_id, :case_id, :contact_method_id, :contact_type_id,
     :consult_status_id, :date, :time, :note,
     consult_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    contact_method
  end

  def self.enumeration_columns
    [
        ["#{ContactMethod}", 'contact_method_id'],
        ["#{ContactType}", 'contact_type_id'],
        ["#{ConsultStatus}", 'consult_status_id']
    ]
  end

  def contact_method
    if contact_method_id
      super
    else
      ContactMethod.default
    end
  end

  def contact_type
    if contact_type_id
      super
    else
      ContactType.default
    end
  end

  def consult_status
    if consult_status_id
      super
    else
      ConsultStatus.default
    end
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "TeleConsult ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Contact Method: ", " #{contact_method}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Contact type: ", " #{contact_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Status: ", " #{consult_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date & Time : ", " #{date} #{time}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

end
