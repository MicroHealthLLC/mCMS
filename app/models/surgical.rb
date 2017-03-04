class Surgical < ApplicationRecord
  belongs_to :user
  # belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :hcpc
  belongs_to :surgery_type, optional: true
  belongs_to :surgery_status, optional: true

  has_many :surgical_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :surgical_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{SurgeryType}", 'surgery_type_id'],
        ["#{SurgeryStatus}", 'surgery_status_id']
    ]
  end

  def surgery_type
    if surgery_type_id
      super
    else
      SurgeryType.default
    end
  end

  def surgery_status
    if surgery_status_id
      super
    else
      SurgeryStatus.default
    end
  end

  def to_s
    name
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Surgery ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>HCPCS: </b> #{hcpc}", :inline_format =>  true
    pdf.text "<b>Medical facility: </b> #{medical_facility}", :inline_format =>  true
    pdf.text "<b>Surgery Type: </b> #{surgery_type}", :inline_format =>  true
    pdf.text "<b>Surgery Status: </b> #{surgery_status}", :inline_format =>  true

    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
  
  def self.safe_attributes
    [:name, :icdcm_code_id, :user_id, :medical_facility,
     :surgery_status_id, :surgery_type_id, :hcpc_id,
     :description,
     surgical_attachments_attributes: [Attachment.safe_attributes]]
  end
end
