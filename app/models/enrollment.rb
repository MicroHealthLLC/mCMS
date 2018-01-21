class Enrollment < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :case
  belongs_to :enrollment_type, optional: true
  belongs_to :enrollment_status, optional: true

  has_many :enrollment_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :enrollment_attachments, reject_if: :all_blank, allow_destroy: true
  has_many :appointment_links, as: :linkable

  validates_presence_of :name, :user_id, :case_id

  def self.safe_attributes
    [:user_id, :name, :location_lat, :location_long,
     :enrollment_location_lat, :enrollment_location_long, :enrollment_location, :enrollment_type_id, :enrollment_status_id, :case_id,
     :date_start, :date_end, :note, enrollment_attachments_attributes: [Attachment.safe_attributes]]
  end

  def self.enumeration_columns
    [
        ["#{EnrollmentType}", 'enrollment_type_id'],
        ["#{EnrollmentStatus}", 'enrollment_status_id']
    ]
  end
  def self.include_enumerations
    includes(:enrollment_status, :enrollment_type).
        references(:enrollment_status, :enrollment_type)
  end

  def self.csv_attributes
    [
        'Name',
        'Location',
        'Enrollment Type',
        'Enrollment Status',
        'Date start',
        'Date end'
    ]
  end


  def enrollment_type
    if self.enrollment_type_id
      super

    else
      EnrollmentType.default
    end
  end

  def enrollment_status
    if self.enrollment_status_id
      super
    else
      EnrollmentStatus.default
    end
  end

  def to_s
    name
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Enrollment ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Enrollment "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Enrollment type: ", " #{enrollment_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Enrollment Status: ", " #{enrollment_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date end: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Enrollment ##{id} </h2><br/>"
    output<<"<b>Location : </b> #{enrollment_location}<br/>"
    output<<"<b>Enrollment Type : </b> #{enrollment_type}<br/>"
    output<<"<b>Enrollment Status : </b> #{enrollment_status}<br/>"
    output<<"<b>Date start : </b> #{date_start}<br/>"
    output<<"<b>Date end : </b> #{date_end}<br/>"
    output<<"<b>Description: </b> #{note} <br/>"
    output.html_safe
  end

  def little_description
    output = 'Enrollment'
    output<< "<p> Location: #{enrollment_location} </p>"
    output<< "<p> Enrollment Type: #{enrollment_type} </p>"
    output<< "<p> Enrollment Status: #{enrollment_status} </p>"
    output<< "<p>  Date start: : #{date_start} </p>"

    output.html_safe
  end

end
