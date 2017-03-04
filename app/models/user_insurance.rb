class UserInsurance < ApplicationRecord
  belongs_to :user
  belongs_to :insurance
  belongs_to :insurance_type, optional: true
  belongs_to :insurance_status, optional: true, foreign_key: :status_id
  has_many :jsignatures, as: :signature_owner, dependent: :destroy

  has_many :user_insurance_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :user_insurance_attachments, reject_if: :all_blank, allow_destroy: true


  def self.enumeration_columns
    [
        ["#{InsuranceType}", 'insurance_type_id'],
        ["#{InsuranceStatus}", 'status_id']
    ]
  end

  def insurance_type
    if insurance_type_id
      super
    else
      InsuranceType.default
    end
  end


   def insurance_status
    if status_id
      super
    else
      InsuranceStatus.default
    end
  end


  def self.safe_attributes
    [:user_id, :insurance_id, :insurance_type_id, :issue_date, :expiration_date,
     :insurance_identifier, :note, :status_id,
     user_insurance_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    insurance
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Insurance ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Insurance name: </b> #{insurance}", :inline_format =>  true
    pdf.text "<b>Insurance type: </b> #{insurance_type}", :inline_format =>  true
    pdf.text "<b>Insurance ID: </b> #{insurance_identifier}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

end
