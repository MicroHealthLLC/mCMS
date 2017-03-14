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

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Behavioral Risk ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Behavioral Risk"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Icdcm Code: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk Type: ", " #{behavioral_risk_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk Status: ", " #{behavioral_risk_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk date ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
  
end
