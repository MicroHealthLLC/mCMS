class Medication < ApplicationRecord
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

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Medication ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
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
  
end
