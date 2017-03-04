class Immunization < ApplicationRecord
  belongs_to :user
  belongs_to :immunization_status, optional: true
  belongs_to :immunization_cvx, optional: true

  has_many :immunization_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :immunization_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :medication


  def self.enumeration_columns
    [
        ["#{ImmunizationStatus}", 'immunization_status_id']
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
    immunization_cvx
  end
    
  def self.safe_attributes
    [:user_id, :medication, :immunization_cvx_id, :total_number_of_doses, :doses_given,
     :next_date_due, :date_immunized, :manufacturer, :lot_number,
     :expiration_date, :immunization_status_id, :description,
     immunization_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Immunization ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Immunization: </b> #{immunization_cvx}", :inline_format =>  true
    pdf.text "<b>Next Date due: </b> #{next_date_due}", :inline_format =>  true
    pdf.text "<b>Date immunized: </b> #{date_immunized}", :inline_format =>  true
    pdf.text "<b>Manufacturer: </b> #{manufacturer}", :inline_format =>  true
    pdf.text "<b>Lot Number: </b> #{lot_number}", :inline_format =>  true
    pdf.text "<b>Expiration date: </b> #{expiration_date}", :inline_format =>  true
    pdf.text "<b>Immunization Status: </b> #{immunization_status}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
end
