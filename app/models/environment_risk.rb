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

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Environment Risk ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Environment Risk "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Icdcm Code: ", " #{icdcm_code}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Environment Risk Type: ", " #{environment_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Environment Risk Status: ", " #{environment_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
end
