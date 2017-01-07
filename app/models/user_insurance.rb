class UserInsurance < ApplicationRecord
  belongs_to :user
  belongs_to :insurance
  belongs_to :insurance_type, optional: true

  has_many :user_insurance_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :user_insurance_attachments, reject_if: :all_blank, allow_destroy: true


  def insurance_type
    if insurance_type_id
      super
    else
      InsuranceType.default
    end
  end


  def self.safe_attributes
    [:user_id, :insurance_id, :insurance_type_id, :issue_date, :expiration_date,
     :insurance_identifier, :note,
     user_insurance_attachments_attributes: [Attachment.safe_attributes]]
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
