class Injury < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :injury_cause, class_name: 'Icd10datum'
  belongs_to :injury_type, optional: true
  belongs_to :injury_status, optional: true


  has_many :worker_compensations

  has_many :injury_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :injury_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  def self.enumeration_columns
    [
        ["#{InjuryType}", 'injury_type_id'],
        ["#{InjuryStatus}", 'injury_status_id']
    ]
  end

  def self.include_enumerations
    includes(:injury_type, :injury_status, :injury_cause).
        references(:injury_type, :injury_status, :injury_cause)
  end

  def self.csv_attributes
    [
    'Injury Name',
    'Snomed',
    'Injury type',

    'Injury cause',
    'Snmed cause',
    'Injury status',

    'Employer',
    'Date of injury',
    'Date resolved'
    ]
  end

  def injury_type
    if injury_type_id
      super
    else
      InjuryType.default
    end
  end

  def injury_status
    if injury_status_id
      super
    else
      InjuryStatus.default
    end
  end


  def to_s
    injury_name
  end

  def self.safe_attributes
    [
        :user_id, :injury_cause_name, :injury_name, :icdcm_code_id, :injury_type_id, :injury_cause_id, :location_lat, :location_long,
        :injury_status_id, :employer, :location_lat, :location_long, :date_of_injury, :date_resolved, :description,
        :snomed_occupation, :snomed_event,
        injury_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Injury ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Injury "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{injury_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Injury Cause name: ", " #{injury_cause_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Injury Status: ", " #{injury_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Injury Type: ", " #{injury_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Injury Cause: ", " #{snomed_event}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date of injury: ", " #{date_of_injury}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date of resolved: ", " #{date_resolved}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end


  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Injury ##{id} </h2><br/>"
    output<<"<b>Name : </b> #{injury_name}<br/>"
    output<<"<b>Injury Cause name : </b> #{injury_cause_name}<br/>"
    output<<"<b>Injury Type : </b> #{injury_type}<br/>"
    output<<"<b>Injury Status : </b> #{injury_status}<br/>"
    output<<"<b>Injury Cause : </b> #{snomed_event}<br/>"
    output<<"<b>date of injury: </b> #{date_of_injury}<br/>"
    output<<"<b>date of resolved: </b> #{date_resolved}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end


end
