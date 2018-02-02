class BehavioralRisk < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :behavioral_risk_type, optional: true
  belongs_to :behavioral_risk_status, optional: true

  has_many :behavioral_risk_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :behavioral_risk_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name
  before_validation do
    if self.date_ended.present? and self.date_started.present? and self.date_started > self.date_ended
      errors[:base] << "Date ended cannot be earlier than date started"
    end
  end

  def self.enumeration_columns
    [
        ["#{BehavioralRiskType}", 'behavioral_risk_type_id'],
        ["#{BehavioralRiskStatus}", 'behavioral_risk_status_id']
    ]
  end

  def self.include_enumerations
    includes(:behavioral_risk_type, :behavioral_risk_status).
        references(:behavioral_risk_type, :behavioral_risk_status)
  end

  def self.csv_attributes
    [
        'Name',
        I18n.t('hcpc'),
        'Medical Facility',
        'Surgery Status',
        'Surgery Type',
        'Surgical Date',
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
    [:name, :user_id, :icdcm_code_id, :date_started, :date_ended, :snomed,
     :behavioral_risk_status_id, :behavioral_risk_type_id, :description,
     behavioral_risk_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Behavioral Risk ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Behavioral Risk"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Snomed: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk Type: ", " #{behavioral_risk_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk Status: ", " #{behavioral_risk_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Behavioral Risk date ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Behavioral Risk ##{id} </h2><br/>"
    output<<"<b>Name : </b> #{name}<br/>"
    output<<"<b>Snomed : </b> #{snomed}<br/>"
    output<<"<b>Behavioral Risk Type : </b> #{behavioral_risk_type}<br/>"
    output<<"<b>Behavioral Risk Status : </b> #{behavioral_risk_status}<br/>"
    output<<"<b>Behavioral Risk date started: </b> #{date_started}<br/>"
    output<<"<b>Behavioral Risk date ended: </b> #{date_ended}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end
  
end
