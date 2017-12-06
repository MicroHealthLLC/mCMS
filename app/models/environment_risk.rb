class EnvironmentRisk < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
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

  def self.include_enumerations
    includes(:environment_type, :environment_status).
        references(:environment_type, :environment_status)
  end

  def self.csv_attributes
    [
    'Name',
    'Snomed',
    'Date started',
    'Date ended',
    'Environment status',
    'Environment type'
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
    [:name, :user_id, :icdcm_code_id, :date_started, :date_ended, :snomed,
     :environment_status_id, :environment_type_id, :description,
     environment_risk_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Environment Risk ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Environment Risk "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Snomed: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Environment Risk Type: ", " #{environment_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Environment Risk Status: ", " #{environment_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Environment Risk ##{id} </h2><br/>"
    output<<"<b>Snomed : </b> #{snomed}<br/>"
    output<<"<b>Environment Risk Type : </b> #{environment_type}<br/>"
    output<<"<b>Environment Risk Status : </b> #{environment_status}<br/>"
    output<<"<b>Date started : </b> #{date_started}<br/>"
    output<<"<b>Date ended : </b> #{date_ended}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

end
