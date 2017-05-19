class JobApplication < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user

  belongs_to :application_type, optional: true
  belongs_to :application_status, optional: true
  belongs_to :interview_type, optional: true
  belongs_to :interview_status, optional: true
  belongs_to :selection_status, optional: true

  has_many :job_application_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :job_application_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :employer

  def self.enumeration_columns
    [
        ["#{ApplicationType}", 'application_type_id'],
        ["#{ApplicationStatus}", 'application_status_id'],
        ["#{InterviewStatus}", 'interview_status_id'],
        ["#{InterviewType}", 'interview_type_id']
    ]
  end

  def application_type
    if application_type_id
      super
    else
      ApplicationType.default
    end
  end

  def application_status
    if application_status_id
      super
    else
      ApplicationStatus.default
    end
  end

  def interview_type
    if interview_type_id
      super
    else
      InterviewType.default
    end
  end

  def interview_status
    if interview_status_id
      super
    else
      InterviewStatus.default
    end
  end

  def selection_status
    if selection_status_id
      super
    else
      SelectionStatus.default
    end
  end


  def to_s
    employer
  end

  def self.safe_attributes
    [
        :user_id, :employer, :position_applied, :projected_salary, :location_lat, :location_long,
        :application_type_id, :application_date, :application_status_id, :interview_type_id,
        :interview_date, :interview_status_id, :selection_status_id,
        job_application_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Job Application ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Job Application "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Employer: ", " #{employer}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Position Applied: ", " #{position_applied}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Projected salary: ", " #{projected_salary}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Application Type: ", " #{application_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Application Status: ", " #{application_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Interview Date: ", " #{interview_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Interview Type: ", " #{interview_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Interview Status: ", " #{interview_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Selection Status: ", " #{selection_status}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Job Application ##{id} </h2><br/>"
    output<<"<b>Employer : </b> #{employer}<br/>"
    output<<"<b>Position Applied : </b> #{position_applied}<br/>"
    output<<"<b>Projected salary : </b> #{projected_salary}<br/>"
    output<<"<b>Application Type : </b> #{application_type}<br/>"
    output<<"<b>Application Status: </b> #{application_status}<br/>"
    output<<"<b>Interview Date: </b> #{interview_date}<br/>"
    output<<"<b>Interview Type </b> #{interview_type}<br/>"
    output<<"<b>Interview Status </b> #{interview_status}<br/>"
    output.html_safe
  end

end
