class MilitaryHistory < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :service_status, optional: true
  belongs_to :service_type, optional: true

  validates_presence_of :user_id

  before_validation do
    if self.text.blank?
      errors[:base] << "Service name cannot be blank"
    end
    if self.date_ended.present? and self.date_started.present? and self.date_started > self.date_ended
      errors[:base] << "Date ended cannot be earlier than date started"
    end
  end

  has_many :military_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :military_history_attachments, reject_if: :all_blank, allow_destroy: true


  def self.enumeration_columns
    [
        ["#{ServiceStatus}", 'service_status_id'],
        ["#{ServiceType}", 'service_type_id']
    ]
  end

  def self.include_enumerations
    includes(:service_type, :service_status).
        references(:service_type, :service_status)
  end

  def self.csv_attributes
    [
        'Service Name',
        'Service type',
        'Service status',
        'Date started',
        'Date ended',
    ]
  end


  def service_status
    super || ServiceStatus.default
  end

  def service_type
    super || ServiceType.default
  end

  def to_s
    text
  end

  def self.safe_attributes
    [
        :user_id, :text, :service_type_id, :service_status_id,
        :date_started, :date_ended, :note,
        military_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Military History ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Military History "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Texte: ", " #{text}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Service Type: ", " #{service_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Service Status: ", " #{service_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end


  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Military History ##{id} </h2><br/>"
    output<<"<b>Title: </b> #{text}<br/>"
    output<<"<b>Service Type : </b> #{service_type}<br/>"
    output<<"<b>Service Status : </b> #{service_status}<br/>"
    output<<"<b>Date started: </b> #{date_started}<br/>"
    output<<"<b>Date ended: </b> #{date_ended}<br/>"
    output<<"<b>Note: </b> #{note} <br/>"
    output.html_safe
  end
end
