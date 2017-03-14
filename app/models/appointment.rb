class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment_type, optional: true
  belongs_to :appointment_status, optional: true
  belongs_to :place_of_service, optional: true
  belongs_to :case, optional: true, foreign_key: :related_to_id

  has_many :appointment_notes, foreign_key: :owner_id, dependent: :destroy
  has_many :appointment_captures, dependent: :destroy
  has_many :jsignatures, as: :signature_owner, dependent: :destroy
  has_many :appointment_dispositions, dependent: :destroy
  has_many :appointment_procedures, dependent: :destroy
  has_many :appointment_links, dependent: :destroy
  has_many :billings, dependent: :destroy

  has_many :appointment_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :appointment_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :date, :title, :description, :with_who_id, :with_who_type

  # attr_accessor :with_who

  scope :not_related, -> {where(related_to_id: nil)}

  scope :my_appointment_created, -> { where(user_id: User.current.id)}
  scope :my_appointment_for_me, -> { where(with_who_id: User.current.id).where(with_who_type: "User")}

  def self.include_enumerations
    includes(:appointment_type, :appointment_status).
        references(:appointment_type, :appointment_status)
  end

  def self.enumeration_columns
    [
        ["#{AppointmentType}", 'appointment_type_id'],
        ["#{AppointmentStatus}", 'appointment_status_id']
    ]
  end

  def to_s
    title
  end

  def visible?
    User.current == user
  end

  def appointment_type
    if appointment_type_id
      super
    else
      AppointmentType.default
    end
  end

  def self.my_appointments
    my_appointment_created.or(Appointment.my_appointment_for_me)
  end


  def appointment_status
    if appointment_status_id
      super
    else
      AppointmentStatus.default
    end
  end

  def date_time
    date.to_s
  end

  def start_time_to_time
    date.strftime("#{Setting['format_date']} %I:%M %p") if date
  end

  def end_time_to_time
    end_time.strftime("#{Setting['format_date']} %I:%M %p") if end_time
  end

  def with_who
    with_who_type.constantize.find(with_who_id)
  rescue StandardError => e
    'No data given'
  end

  def with_who=(user_or_contact)
    if user_or_contact.class == User
      self.with_who_id = user_or_contact.try(:id)
      self.with_who_type = user_or_contact.class
    end
  end


  def self.safe_attributes
    [:title, :description, :time, :with_who_id, :with_who_type,
     :appointment_type_id, :appointment_status_id, :end_time, :place_of_service_id,
     :user_id, :date, :related_to_id, appointment_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Apointment ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Appointment"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Appointment type: ", " #{appointment_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Appointment status: ", " #{appointment_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date: ", " #{date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Time: ", " #{time}"]], :column_widths => [ 150, 373])
    pdf.table([[ "With: ", " #{with_who}"]], :column_widths => [ 150, 373])

  end

  def for_mail
    output = ""
    output<< "<h2>Appoitment ##{id} </h2>"
    output.html_safe
  end


end
