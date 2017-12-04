class HealthCareFacility < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user

  belongs_to :health_care_facility_status, :optional=> true
  belongs_to :health_care_facility_type, :optional=> true

  validates_presence_of :name, :user_id

  has_many :health_care_facility_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :health_care_facility_attachments, reject_if: :all_blank, allow_destroy: true

  def self.enumeration_columns
    [
        ["#{HealthCareFacilityStatus}", 'health_care_facility_status_id'],
        ["#{HealthCareFacilityType}", 'health_care_facility_type_id']
    ]
  end

  def self.include_enumerations
    includes(:health_care_facility_status, :health_care_facility_type).
        references(:health_care_facility_status, :health_care_facility_type)
  end

  def self.csv_attributes
    [
        'Name',
        'health_care_facility_type',
        'health_care_facility_status',
        'health_care_facility_contact',
        'Date started',
        'Date ended'
    ]
  end


  def health_care_facility_status
    if health_care_facility_status_id
      super
    else
      HealthCareFacilityStatus.default
    end
  end

  def health_care_facility_type
    if health_care_facility_type_id
      super
    else
      HealthCareFacilityType.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [
        :user_id, :name, :health_care_facility_type_id,
        :health_care_facility_status_id,
        :health_care_facility_contact, :date_started, :location_lat, :location_long,
        :date_end, :description,
        :health_care_facility_attachments_attributes=> [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Health Care Facility ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Health Care Facility "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Health Care Facility Type: ", " #{health_care_facility_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Health Care Facility Status: ", " #{health_care_facility_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Health Care Facility Contact: ", " #{health_care_facility_contact}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date end: ", " #{date_end}"]], :column_widths => [ 150, 373])

    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Health Care Facility ##{id} </h2><br/>"
    output<<"<b>Name : </b> #{name}<br/>"
    output<<"<b>Health Care Facility Type : </b> #{health_care_facility_type}<br/>"
    output<<"<b>Health Care Facility Status : </b> #{health_care_facility_status}<br/>"
    output<<"<b>Health Care Facility Contact : </b> #{health_care_facility_contact}<br/>"
    output<<"<b>Date started : </b> #{date_started}<br/>"
    output<<"<b>Date end : </b> #{date_end}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

end
