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
     :amount_paid, :note, :appointment_id, :amount_collected,
     :associated_icd, :associated_hcpc,
     billing_attachments_attributes: [BillingAttachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Billing ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Billing"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Bill type: ", " #{bill_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Bill status: ", " #{bill_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Bill Date: ", " #{bill_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Bill Amount: ", " #{bill_amount}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Accept Assignment: ", " #{accept_assignment}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Resubmission Code: ", " #{resubmission_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Original Reference Number: ", " #{original_reference_number}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Prior Authorization Number: ", " #{prior_authorization_number}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Outside Lab: ", " #{outside_lab}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Outside Lab Charges: ", " #{outside_lab_charges}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Other Source: ", " #{other_source}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Total Charge: ", " #{total_charge}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Amount Paid: ", " #{amount_paid}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Amount Collected: ", " #{amount_collected}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Associated ICD10: ", " #{associated_icd}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Associated HCPCS: ", " #{associated_hcpc}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])


  end

end
