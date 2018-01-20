class Immunization < ApplicationRecord
  belongs_to :user
  belongs_to :immunization_status, optional: true
  belongs_to :immunization_cvx, optional: true

  has_many :immunization_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :immunization_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  before_validation do
    if self.snomed.blank?
      errors[:base] << "Medication cannot be blank"
    end
  end

  def self.enumeration_columns
    [
        ["#{ImmunizationStatus}", 'immunization_status_id']
    ]
  end
  
  def self.include_enumerations
    includes(:immunization_status).
        references(:immunization_status)
  end

  def self.csv_attributes
    [
    'Medication',

    'Next date due',
    'Date immunized',
    'Manufacturer',
    'Lot number',
    'Expiration date',
    'Immunization status'
    ]
  end
  

  def immunization_status
    if immunization_status_id
      super
    else
      ImmunizationStatus.default
    end
  end

  def to_s
    snomed
  end
    
  def self.safe_attributes
    [:user_id, :medication, :immunization_cvx_id, :total_number_of_doses, :doses_given,
     :next_date_due, :date_immunized, :manufacturer, :lot_number, :snomed,
     :expiration_date, :immunization_status_id, :description,
     immunization_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Immunization ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Immunization "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Immunization: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Next Date due: ", " #{next_date_due}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date immunized: ", " #{date_immunized}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Manufacturer: ", " #{manufacturer}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Lot Number: ", " #{lot_number}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Expiration date: ", " #{expiration_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Immunization Status: ", " #{immunization_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Immunization ##{id} </h2>"
    output<<"<b>Immunization: </b> #{snomed}<br/>"
    output<<"<b>Next Date due: </b> #{next_date_due}<br/>"
    output<<"<b>Date immunized:</b> #{date_immunized}<br/>"
    output<<"<b>Manufacturer: </b> #{manufacturer}<br/>"
    output<<"<b>Lot Number: </b> #{lot_number}<br/>"
    output<<"<b>Expiration date:: </b> #{expiration_date}<br/>"
    output<<"<b>Immunization Status:: </b> #{immunization_status}<br/>"


    output<<"<b>Description: </b> #{description}<br/>"

    output.html_safe
  end
end
