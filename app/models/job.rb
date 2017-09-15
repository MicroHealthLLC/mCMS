class Job < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :application_stage
  belongs_to :application_status
  belongs_to :job_app
  belongs_to :position_type

  validates_presence_of :user_id, :title


  def self.safe_attributes
    [:title, :employer, :application_stage_id, :user_id, :job_app_id, :location_lat, :location_long,
     :position_type_id, :date, :application_status_id]
  end

  def self.enumeration_columns
    [
        ["#{ApplicationStage}", 'application_stage_id'],
        ["#{PositionType}", 'position_type_id'],
        ["#{ApplicationStatus}", 'application_status_id']
    ]
  end

  def application_stage
    if application_stage_id
      super
    else
      ApplicationStage.default
    end
  end

  def application_status
    if application_status_id
      super
    else
      ApplicationStatus.default
    end
  end

  def position_type_id
    if position_type
      super
    else
      PositionType.default
    end
  end

  def to_s
    title
  end

  def to_pdf(pdf, show_user = true)
    pdf.table([[" Job  "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Employer: ", " #{employer}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Application Stage: ", " #{application_stage}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Position Type: ", " #{position_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Application Status: ", " #{application_status}"]], :column_widths => [ 150, 373])
  end

end
