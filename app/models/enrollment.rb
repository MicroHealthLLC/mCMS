class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :case
  belongs_to :enrollment_type, optional: true
  belongs_to :enrollment_status, optional: true

  has_many :enrollment_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :enrollment_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :name, :user_id, :note, :case_id

  def self.safe_attributes
    [:user_id, :name, :enrollment_type_id, :enrollment_status_id, :case_id,
     :date_start, :date_end, :note, enrollment_attachments_attributes: [Attachment.safe_attributes]]
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

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Enrollment ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Enrollment type: </b> #{enrollment_type}", :inline_format =>  true
    pdf.text "<b>Enrollment Status: </b> #{enrollment_status}", :inline_format =>  true
    pdf.text "<b>Date start: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>Date end: </b> #{date_end}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end
end
