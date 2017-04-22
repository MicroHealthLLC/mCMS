class Teleconsult < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
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

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "TeleConsult ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Teleconsult "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Contact Method: ", " #{contact_method}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Contact type: ", " #{contact_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Status: ", " #{consult_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date & Time : ", " #{date} #{time}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def little_description
    output = 'Teleconsult'
    output<< "<p> Type: #{contact_type} </p>"
    output<< "<p>Status:  #{consult_status}</p>"
    output<< "<p> Date & Time: #{date} #{time}</p>"
    output.html_safe
  end


  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>TeleConsult ##{id} </h2>"
    output<<"<b>Contact Method: </b> #{contact_method}<br/>"
    output<<"<b>Contact type: </b> #{contact_type}<br/>"
    output<<"<b>Status: </b> #{consult_status}<br/>"
    output<<"<b>Date & Time: </b> #{date} #{time}<br/>"

    output<<"<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
