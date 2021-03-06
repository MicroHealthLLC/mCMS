class WorkerCompensation < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :injury
  belongs_to :case

  belongs_to :compensation_type, optional: true
  belongs_to :compensation_status, optional: true

  has_many :worker_compensation_attachments, foreign_key: :owner_id, dependent: :destroy
  has_many :appointment_links, as: :linkable
  accepts_nested_attributes_for :worker_compensation_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :injury_id, :case_id
  before_validation do
    if self.date_of_compensation_end.present? and self.date_of_compensation_start.present? and self.date_of_compensation_start > self.date_of_compensation_end
      errors[:base] << "End date cannot be earlier than start date"
    end
  end

  def self.enumeration_columns
    [
        ["#{CompensationType}", 'compensation_type_id'],
        ["#{CompensationStatus}", 'compensation_status_id']
    ]
  end


  def self.include_enumerations
    includes(:compensation_type, :compensation_status, :injury).
        references(:compensation_type, :compensation_status, :injury)
  end

  def self.csv_attributes
    [
    'Injury',
    'Compensation type',
    'Compensation status',
    'Date of compensation start',
    'Date of compensation end'
    ]
  end


  def compensation_type
    if compensation_type_id
      super
    else
      CompensationType.default
    end
  end

  def compensation_status
    if compensation_status_id
      super
    else
      CompensationStatus.default
    end
  end


  def to_s
    injury.to_s
  end

  def self.safe_attributes
    [
        :user_id, :injury_id, :compensation_type_id, :compensation_status_id, :case_id,
        :description, :date_of_compensation_start, :date_of_compensation_end,
        worker_compensation_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Worker Compensation ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Worker Compensation "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Injury: ", " #{injury.to_s}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Compensation Type: ", " #{compensation_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Compensation status: ", " #{compensation_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date  Of Compensation start: ", " #{date_of_compensation_start}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Date Of Compensation End: ", " #{date_of_compensation_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def little_description
    output = 'Worker Compensation'
    output<< "<p>Injury #{injury.to_s} </p>"
    output<< "<p>Type  #{compensation_type}</p>"
    output<< "<p>Status #{compensation_status}</p>"
    output<< "<p>Date start #{date_of_compensation_start}</p>"
    output<< "<p>Date end #{date_of_compensation_end}</p>"

    output.html_safe
  end
  
  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2> Worker Compensation ##{id} </h2>"
    output<<"<b>Injury: </b> #{injury.to_s}<br/>"
    output<<"<b>Compensation Type: </b> #{compensation_type}<br/>"
    output<<"<b>Compensation Status: </b> #{compensation_status}<br/>"
    output<<"<b>Date  Of Compensation start: </b> #{date_of_compensation_start}<br/>"
    output<<"<b>Date Of Compensation End: </b> #{date_of_compensation_end}<br/>"

    output<<"<b>Description: </b> #{description}<br/>"

    output.html_safe
  end
end
