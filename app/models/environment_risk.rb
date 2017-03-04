class EnvironmentRisk < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :environment_type, optional: true
  belongs_to :environment_status, optional: true

  has_many :environment_risk_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :environment_risk_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{EnvironmentType}", 'environment_type_id'],
        ["#{EnvironmentStatus}", 'environment_status_id']
    ]
  end

  def environment_type
    if environment_type_id
      super
    else
      EnvironmentType.default
    end
  end

  def environment_status
    if environment_status_id
      super
    else
      EnvironmentStatus.default
    end
  end


  def to_s
    name
  end
  
  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_started, :date_ended,
     :environment_status_id, :environment_type_id, :description,
     environment_risk_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Environment Risk ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Icdcm Code: </b> #{icdcm_code}", :inline_format =>  true
    pdf.text "<b>Environment Risk Type: </b> #{environment_type}", :inline_format =>  true
    pdf.text "<b>Environment Risk Status: </b> #{environment_status}", :inline_format =>  true
    pdf.text "<b>date started: </b> #{date_started}", :inline_format =>  true
    pdf.text "<b>date ended: </b> #{date_ended}", :inline_format =>  true
    pdf.text "<b>description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
  end
end
