class UserInsurance < ApplicationRecord
  belongs_to :user
  belongs_to :insurance
  belongs_to :insurance_type, optional: true
  belongs_to :insurance_status, optional: true, foreign_key: :status_id
  belongs_to :insurance_relationship, optional: true
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

   def insurance_relationship
    if insurance_relationship_id
      super
    else
      InsuranceRelationship.default
    end
  end


  def self.safe_attributes
    [:user_id, :insurance_id, :insurance_type_id, :issue_date, :expiration_date, :group_id,
     :insurance_identifier, :note, :status_id, :insurance_relationship_id, :insured_name,
     user_insurance_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    insurance
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Insurance ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Insurance name: ", " #{insurance}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Insurance Relationship: ", " #{insurance_relationship}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Insured Name: ", " #{insured_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Insurance type: ", " #{insurance_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Insurance ID: ", " #{insurance_identifier}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

end
