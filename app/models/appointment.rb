class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment_type, optional: true
  belongs_to :appointment_status, optional: true

  has_many :appointment_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :appointment_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :date, :time, :title, :description, :with_who_id, :with_who_type

  attr_accessor :with_who

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
    [:title, :description, :time, :appointment_type_id, :appointment_status_id,
     :user_id, :date]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Apoinjtment ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    end

  def for_mail
    output = ""
    output<< "<h2>Appoitment ##{id} </h2>"
    output.html_safe
  end


end
