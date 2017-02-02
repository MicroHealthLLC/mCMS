class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment_type, optional: true
  belongs_to :appointment_status, optional: true
  belongs_to :case, optional: true, foreign_key: :related_to_id

  has_many :appointment_notes, foreign_key: :owner_id, dependent: :destroy
  has_many :appointment_captures, dependent: :destroy
  has_many :appointment_dispositions, dependent: :destroy
  has_many :appointment_procedures, dependent: :destroy

  has_many :appointment_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :appointment_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :date, :time, :title, :description, :with_who_id, :with_who_type

  # attr_accessor :with_who

  scope :not_related, -> {where(related_to_id: nil)}

  scope :my_appointment_created, -> { where(user_id: User.current.id)}
  scope :my_appointment_for_me, -> { where(with_who_id: User.current.id).where(with_who_type: "User")}

  def self.include_enumerations
    includes(:appointment_type, :appointment_status).
        references(:appointment_type, :appointment_status)
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
    "#{date} #{time}".strip
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
     :appointment_type_id, :appointment_status_id,
     :user_id, :date, :related_to_id, appointment_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Apointment ##{id}", :style => :bold}
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
    pdf.text "<b>Appointment type: </b> #{appointment_type}", :inline_format =>  true
    pdf.text "<b>Appointment status: </b> #{appointment_status}", :inline_format =>  true
    pdf.text "<b>Date: </b> #{date}", :inline_format =>  true
    pdf.text "<b>Time: </b> #{time}", :inline_format =>  true
    pdf.text "<b>With: </b> #{with_who}", :inline_format =>  true

  end

  def for_mail
    output = ""
    output<< "<h2>Appoitment ##{id} </h2>"
    output.html_safe
  end


end
