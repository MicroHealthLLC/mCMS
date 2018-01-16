class Housing < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :housing_status, :optional=> true
  belongs_to :housing_type, :optional=> true
  belongs_to :cohabitation_type, :optional=> true
  belongs_to :primary_address, :optional=> true, class_name: 'Address'

  has_many :housing_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :housing_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id


  def self.enumeration_columns
    [
        ["#{HousingStatus}", 'housing_status_id'],
        ["#{HousingType}", 'housing_type_id']
    ]
  end

  def self.include_enumerations
    includes(:housing_status, :housing_type).
        references(:housing_status, :housing_type)
  end

  def self.csv_attributes
    [
    'Housing Type',
    'Housing status',
    'Primary address',
    'Estimated monthly payment',
    'Date start',
    'Date end'
    ]
  end
  

  def housing_status
    if housing_status_id
      super
    else
      HousingStatus.default
    end
  end

  def housing_type
    if housing_type_id
      super
    else
      HousingType.default
    end
  end


  def to_s
    snomed
  end

  def self.safe_attributes
    [:user_id, :title, :snomed,
     :housing_status_id, :description,
     :primary_address_id, :address, :location, :location_lat, :location_long, :estimated_monthly_payment,
     :date_start, :date_end,
     housing_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Housing ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Housing "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Snomed: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Housing Status: ", " #{housing_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Primary Address: ", " #{address}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Start date: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "End date: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end


  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Housing ##{id} </h2><br/>"
    output<<"<b>Snomed : </b> #{snomed}<br/>"
    output<<"<b>Housing Status : </b> #{housing_status}<br/>"
    output<<"<b>Primary Address : </b> #{address}<br/>"
    output<<"<b>Date start : </b> #{date_start}<br/>"
    output<<"<b>Date end : </b> #{date_end}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end
  
end
