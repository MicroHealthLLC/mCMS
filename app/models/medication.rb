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
    pdf.font_size(25){  pdf.text "Medication ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Medication: </b> #{medication_synonym}", :inline_format =>  true
    pdf.text "<b>Medication TTY: </b> #{medication_tty}", :inline_format =>  true
    pdf.text "<b>Direction: </b> #{description}", :inline_format =>  true
    pdf.text "<b>Count: </b> #{dose}", :inline_format =>  true
    pdf.text "<b>Date Prescribed: </b> #{date_prescribed}", :inline_format =>  true
    pdf.text "<b>Date Expired: </b> #{date_expired}", :inline_format =>  true
    pdf.text "<b>Total Refill: </b> #{total_refills}", :inline_format =>  true
    pdf.text "<b>Refill Left: </b> #{refills_left}", :inline_format =>  true
    pdf.text "<b>Medication Status: </b> #{medication_status}", :inline_format =>  true

    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(medication_description)}", :inline_format =>  true
  end
  
end
