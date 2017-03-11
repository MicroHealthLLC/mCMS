class Billing < ApplicationRecord
  belongs_to :user
  belongs_to :appointment
  belongs_to :outside_lab, optional: true
  belongs_to :bill_type, optional: true
  belongs_to :bill_status, optional: true
  belongs_to :accept_assignment, optional: true
  belongs_to :other_source, optional: true , class_name: 'CaseSupport'

  validates_presence_of :user_id, :appointment_id

  has_many :billing_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :billing_attachments, reject_if: :all_blank, allow_destroy: true


  def self.enumeration_columns
    [
        ["#{BillStatus}", 'bill_status_id']
    ]
  end

  def self.default_includes
    includes(:appointment, :user=> :core_demographic).
        references(:appointment, :user=> :core_demographic)
  end

  def bill_status
    if self.bill_status_id
      super
    else
      BillStatus.default
    end
  end

  def bill_type
    if self.bill_type_id
      super
    else
      BillType.default
    end
  end

  def accept_assignment
    if self.accept_assignment_id
      super
    else
      AcceptAssignment.default
    end
  end

  def outside_lab
    if self.outside_lab_id
      super
    else
      OutsideLab.default
    end
  end

  def to_s
    bill_type
  end

  def self.safe_attributes
    [:user_id, :bill_type_id, :bill_status_id,
     :bill_date, :bill_amount, :accept_assignment_id,
     :resubmission_code, :original_reference_number,
     :prior_authorization_number, :outside_lab_id,
     :outside_lab_charges, :other_source_id, :total_charge,
     :amount_paid, :note, :appointment_id,
     billing_attachments_attributes: [BillingAttachment.safe_attributes]
    ]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Billing ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Bill type: </b> #{bill_type}", :inline_format =>  true
    pdf.text "<b>Bill status: </b> #{bill_status}", :inline_format =>  true
    pdf.text "<b>Bill Date: </b> #{bill_date}", :inline_format =>  true
    pdf.text "<b>Bill Amount: </b> #{bill_amount}", :inline_format =>  true
    pdf.text "<b>Accept Assignment: </b> #{accept_assignment}", :inline_format =>  true
    pdf.text "<b>Resubmission Code: </b> #{resubmission_code}", :inline_format =>  true
    pdf.text "<b>Original Reference Number: </b> #{original_reference_number}", :inline_format =>  true
    pdf.text "<b>Prior Authorization Number: </b> #{prior_authorization_number}", :inline_format =>  true
    pdf.text "<b>Outside Lab: </b> #{outside_lab}", :inline_format =>  true
    pdf.text "<b>Outside Lab Charges: </b> #{outside_lab_charges}", :inline_format =>  true
    pdf.text "<b>Other Source: </b> #{other_source}", :inline_format =>  true
    pdf.text "<b>Total Charge: </b> #{total_charge}", :inline_format =>  true
    pdf.text "<b>Amount Paid: </b> #{amount_paid}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true


  end

end
