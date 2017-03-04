class BehavioralRisk < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :behavioral_risk_type, optional: true
  belongs_to :behavioral_risk_status, optional: true

  has_many :behavioral_risk_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :behavioral_risk_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{BehavioralRiskType}", 'behavioral_risk_type_id'],
        ["#{BehavioralRiskStatus}", 'behavioral_risk_status_id']
    ]
  end

  def behavioral_risk_type
    if behavioral_risk_type_id
      super
    else
      BehavioralRiskType.default
    end
  end

  def behavioral_risk_status
    if behavioral_risk_status_id
      super
    else
      BehavioralRiskStatus.default
    end
  end


  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_started, :date_ended,
     :behavioral_risk_status_id, :behavioral_risk_type_id, :description,
     behavioral_risk_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Behavioral Risk ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Icdcm Code: </b> #{icdcm_code}", :inline_format =>  true
    pdf.text "<b>Behavioral Risk Type: </b> #{behavioral_risk_type}", :inline_format =>  true
    pdf.text "<b>Behavioral Risk Status: </b> #{behavioral_risk_status}", :inline_format =>  true
    pdf.text "<b>Behavioral Risk date started: </b> #{date_started}", :inline_format =>  true
    pdf.text "<b>Behavioral Risk date ended: </b> #{date_ended}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
  
end
