class Transport < ApplicationRecord
  audited
  belongs_to :user

  belongs_to :transport_type, optional: true
  belongs_to :transport_status, optional: true
  belongs_to :transport_location, optional: true
  belongs_to :case, optional: true

  has_many :transport_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :transport_attachments, reject_if: :all_blank, allow_destroy: true

  has_many :transport_notes, foreign_key: :owner_id, dependent: :destroy

  validates_presence_of :user_id, :reason

  def self.include_enumerations
    includes(:transport_type, :transport_status, :case, :transport_location).
        references(:transport_type, :transport_status, :case, :transport_location)
  end

  def self.csv_attributes
    [
        'Reason',
        'Transport type',
        'Location',
        'Transport location',
        'Transport status',
        'Date time',
    ]
  end


  def self.enumeration_columns
    [
        ["#{TransportType}", 'transport_type_id'],
        ["#{TransportStatus}", 'transport_status_id']
    ]
  end

  def to_s
    reason
  end

  def transport_location
    super || TransportLocation.default
  end

  def transport_type
    super || TransportType.default
  end

  def transport_status
    super || TransportStatus.default
  end

  def self.safe_attributes
    [:user_id, :reason, :transport_type_id, :description, :case_id, :location, :location_lat, :location_long,
     :transport_location_id, :transport_status, :date_time]
  end

  def little_description
    output = 'Transport'
    output<<"<p>Reason:  #{reason}</p>"
    output<<"<p>Transport Type:  #{transport_type}</p>"
    output<<"<p>Transport Status:  #{transport_status}</p>"
    output<<"<p>Transport Location:  #{transport_location}</p>"
    output<<"<p>date & time:  #{ format_date_time date_time}</p>"


    output.html_safe
  end



  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Transport ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Transport "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Reason: ", " #{reason}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Transport Type: ", " #{transport_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Transport Status: ", " #{transport_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Transport Location: ", " #{transport_location}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date & time: ", " #{date_time}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

end
