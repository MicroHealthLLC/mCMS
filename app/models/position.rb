class Position < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  # belongs_to :organization
  belongs_to :pay_rate_type, optional: true, foreign_key: :pay_rate_id
  belongs_to :employment_type, optional: true
  belongs_to :position_status, optional: true, foreign_key: :status_id
  belongs_to :location_type, optional: true
  belongs_to :occupation, optional: true


  has_many :position_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :position_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :title
  before_validation do
    if self.date_end.present? and self.date_start.present? and self.date_start > self.date_end
      errors[:base] << "End date cannot be earlier than start date"
    end
  end

  def self.enumeration_columns
    [
        ["#{PayRateType}", 'pay_rate_id'],
        ["#{EmploymentType}", 'employment_type_id'],
        ["#{PositionStatus}", 'status_id']
    ]
  end


  def self.include_enumerations
    includes(:position_status, :employment_type, :location_type, :occupation).
        references(:position_status, :employment_type , :location_type, :occupation)
  end

  def self.csv_attributes
    [
    I18n.t('title'),
    'Occupation',
    I18n.t('enumeration_location_type'),

    I18n.t('date_start'),
    I18n.t('date_end'),
    I18n.t('employment_type'),

    I18n.t('position_status'),
    I18n.t('estimated_monthly_amount') 
    ]
  end

  

  def pay_rate_type
    if pay_rate_id
      super
    else
      PayRateType.default
    end
  end

 def position_status
    if status_id
      super
    else
      PositionStatus.default
    end
 end
  alias status position_status

  def employment_type
    if employment_type_id
      super
    else
      EmploymentType.default
    end
  end

  def position_type
    employment_type
  end

  def location_type
    if location_type_id
      super
    else
      LocationType.default
    end
  end
  def visible?
    User.current.permitted_users.include? user
  end

  def self.safe_attributes
    [:user_id, :title, :position_description, :estimated_monthly_amount, :location_lat, :location_long,
     :location_type_id, :special_requirement, :note, :location_lat, :location_long, :status_id, :occupation_id, :snomed,
     :date_start, :date_end, :organization_id, :salary, :pay_rate_id, :employment_type_id,
     position_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    title
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Position ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Position "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "title: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Position description: ", " #{ActionView::Base.full_sanitizer.sanitize(position_description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Position Status: ", " #{position_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Location: ", " #{location_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Special requirement: ", " #{special_requirement}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date end: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Employment type: ", " #{employment_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Occupation: ", " #{occupation}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Position ##{id} </h2>"
    output<<"<b>title: </b> #{snomed}<br/>"
    output<<"<b>Position description: </b> #{position_description}<br/>"
    output<<"<b>Position Status: </b> #{position_status}<br/>"
    output<<"<b>Location: </b> #{location_type}<br/>"
    output<<"<b>Special requirement: </b> #{special_requirement}<br/>"
    output<<"<b>Date start: </b> #{date_start}<br/>"
    output<<"<b>Date end: </b> #{date_end}<br/>"
    output<<"<b>Employment type: </b> #{employment_type}<br/>"
    output<<"<b>Occupation: </b> #{occupation}<br/>"
    output<<"<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
