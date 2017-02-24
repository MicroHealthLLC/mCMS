class Certification < ApplicationRecord
  belongs_to :certification_type
  belongs_to :certification_status, :foreign_key => :status_id
  belongs_to :user

  has_many :certification_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :certification_attachments, reject_if: :all_blank, allow_destroy: true

  after_save :send_notification
  def send_notification
    UserMailer.certification_notification(self).deliver_later
  end

  def certification_type
    if certification_type_id
      super
    else
      CertificationType.default
    end
  end

   def certification_status
    if status_id
      super
    else
      CertificationStatus.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :certification_type_id, :user_id, :date_received, :note, :date_expired, :status_id,
     certification_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Certification ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Certification type: </b> #{certification_type}", :inline_format =>  true
    pdf.text "<b>Certification Status: </b> #{certification_status}", :inline_format =>  true
    pdf.text "<b>Date received: </b> #{date_received}", :inline_format =>  true
    pdf.text "<b>Date expired: </b> #{date_expired}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Certification ##{id} </h2>"
    output<< "<b>Certification type: </b> #{certification_type}<br/>"
    output<< "<b>Certification Status:  </b> #{certification_sttaus}<br/>"
    output<< "<b>Date received: </b> #{date_received}<br/>"
    output<< "<b>Date expired: </b> #{date_expired}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
