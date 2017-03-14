class IncidentHistory < ApplicationRecord
  belongs_to :user
  belongs_to :incident_category, optional: true
  belongs_to :incident_type, optional: true
  belongs_to :state_type, optional: true
  belongs_to :country_type, optional: true
  belongs_to :operation, optional: true
  belongs_to :verified_personnel_casualty_reporting_system, optional: true
  belongs_to :line_of_duty_investigation, optional: true

  has_many :incident_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :incident_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :incident

  def self.enumeration_columns
    [
        ["#{IncidentCategory}", 'incident_category_id'],
        ["#{LineOfDutyInvestigation}", 'line_of_duty_investigation_id'],
        ["#{VerifiedPersonnelCasualtyReportingSystem}", 'verified_personnel_casualty_reporting_system_id'],
        ["#{IncidentType}", 'incident_type_id'],
    ]
  end

  def incident_category
    if self.incident_category_id
      super
    else
      IncidentCategory.default
    end
  end

  def line_of_duty_investigation
    if self.line_of_duty_investigation_id
      super
    else
      LineOfDutyInvestigation.default
    end
  end

  def verified_personnel_casualty_reporting_system
    if self.verified_personnel_casualty_reporting_system_id
      super
    else
      VerifiedPersonnelCasualtyReportingSystem.default
    end
  end

  def operation
    if self.operation_id
      super
    else
      Operation.default
    end
  end

  def incident_type
    if self.incident_type_id
      super
    else
      IncidentType.default
    end
  end

  def state_type
    if state_id
      StateType.find_by(id: state_id)
    else
      StateType.default
    end
  end

  def country_type
    if country_id
      CountryType.find_by(id: country_id)
    else
      CountryType.default
    end
  end

  def to_s
    incident
  end

  def self.safe_attributes
    [
        :user_id, :incident, :incident_type_id,
        :incident_category_id, :date_of_incident, :date_diagnosed,
        :incident_location_address, :incident_location_city, :state_id,
        :country_id, :operation_id, :verified_personnel_casualty_reporting_system_id,
        :line_of_duty_investigation_id,
        :cause_of_injury, :injury_description, :pending_operation_procedure,
        incident_history_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Incident History ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Incident History "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Incident: ", " #{incident}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Incident Type: ", " #{incident_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Incident Category: ", " #{incident_category}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date of incident: ", " #{date_of_incident}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date diagnosed: ", " #{date_diagnosed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Location Address: ", " #{incident_location_address}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Location City: ", " #{incident_location_city}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Location State: ", " #{state_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Verified personnel casualty reporting system  : ", " #{verified_personnel_casualty_reporting_system}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Line of duty investigation id  : ", " #{line_of_duty_investigation}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Cause of injury : ", " #{cause_of_injury}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(injury_description)}"]], :column_widths => [ 150, 373])
  end

end
