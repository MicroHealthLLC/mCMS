class Medication < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :medication_status, optional: true

  has_many :medication_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :medication_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :medication

  def self.enumeration_columns
    [
        ["#{MedicationStatus}", 'medication_status_id']
    ]
  end

  def self.include_enumerations
    includes(:medication_status).
        references(:medication_status)
  end

  def self.csv_attributes
    [
    'Medication',
    'Count',
    'Directions',

    'Date prescribed',
    'Date expired',
    'Total refills',

    'Refills left',
    'Medication status',

    ]
  end

  

  def medication_status
    if medication_status_id
      super
    else
      MedicationStatus.default
    end
  end

  def to_s
    medication_synonym
  end

  def self.safe_attributes
    [:user_id, :medication, :medication_synonym, :dose, :rxcui, :medication_tty, :description,
     :date_prescribed, :date_expired,
     :total_refills, :refills_left, :medication_status_id, :medication_description,
     medication_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Medication ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Medication "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Medication: ", " #{medication_synonym}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Medication TTY: ", " #{medication_tty}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Direction: ", " #{description}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Count: ", " #{dose}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Prescribed: ", " #{date_prescribed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Expired: ", " #{date_expired}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Total Refill: ", " #{total_refills}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Refill Left: ", " #{refills_left}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Medication Status: ", " #{medication_status}"]], :column_widths => [ 150, 373])

    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(medication_description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Medication ##{id} </h2><br/>"
    output<<"<b>Medication : </b> #{medication_synonym}<br/>"
    output<<"<b>Medication  TTY: </b> #{medication_tty}<br/>"
    output<<"<b>Direction : </b> #{description}<br/>"
    output<<"<b>count : </b> #{dose}<br/>"
    output<<"<b>Date Prescribed: </b> #{date_prescribed}<br/>"
    output<<"<b>Date Expired: </b> #{date_expired}<br/>"
    output<<"<b>Total Refill: </b> #{total_refills}<br/>"
    output<<"<b>Refill Left: </b> #{refills_left}<br/>"
    output<<"<b>Medication Status: </b> #{medication_status}<br/>"
    output<<"<b>Description: </b> #{medication_description} <br/>"
    output.html_safe
  end
  
end
