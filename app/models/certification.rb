class Certification < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :certification_type
  belongs_to :certification_status, :foreign_key => :status_id
  belongs_to :user

  has_many :certification_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :certification_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name
  before_validation do
    if self.date_expired.present? and self.date_received.present? and self.date_received > self.date_expired
      errors[:base] << "Date expired cannot be earlier than date received"
    end
  end

  def self.enumeration_columns
    [
        ["#{CertificationType}", 'certification_type_id'],
        ["#{CertificationStatus}", 'status_id']
    ]
  end

  def self.include_enumerations
    includes(:certification_status, :certification_type).
        references(:certification_status, :certification_type)
  end

  def self.csv_attributes
    [
        I18n.t('label_name') ,
        I18n.t('enumeration_certification_type') ,
        I18n.t('certification_status') ,
        I18n.t('education_date_received') ,
        I18n.t('education_date_expired')

    ]
  end

  def certification_type
    if certification_type_id
      super
    else
      CertificationType.default
    end
  end

  def certification_status
    if status_id
      super
    else
      CertificationStatus.default
    end
  end
  alias status certification_status

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :certification_type_id, :user_id, :date_received, :note, :date_expired, :status_id, :certifying_organization, :location_lat, :location_long,
     certification_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Certification ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Certification "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Certifying Organization: ", " #{certifying_organization}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Certification type: ", " #{certification_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Certification Status: ", " #{certification_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date received: ", " #{date_received}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date expired: ", " #{date_expired}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])

  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Certification ##{id} </h2>"
    output<< "<b>Certification type: </b> #{certification_type}<br/>"
    output<< "<b>Certifying Organization: </b> #{certifying_organization}<br/>"
    output<< "<b>Certification Status:  </b> #{certification_status}<br/>"
    output<< "<b>Date received: </b> #{date_received}<br/>"
    output<< "<b>Date expired: </b> #{date_expired}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
