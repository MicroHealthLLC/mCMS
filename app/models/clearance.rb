class Clearance < ApplicationRecord
  belongs_to :clearence_type
  belongs_to :clearence_status, foreign_key: :status_id
  belongs_to :user

  has_many :clearance_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :clearance_attachments, reject_if: :all_blank, allow_destroy: true
  after_save :send_notification
  def send_notification
    UserMailer.clearance_notification(self).deliver_later
  end

  def self.enumeration_columns
    [
        ["#{ClearenceStatus}", 'status_id'],
        ["#{ClearenceType}", 'clearence_type_id']
    ]
  end

  def clearence_status
    if status_id
      super
    else
      ClearenceStatus.default
    end
  end

  def clearence_type
    if clearence_type_id
      super
    else
      ClearenceType.default
    end
  end

  def self.safe_attributes
    [:clearence_type_id, :user_id, :date_received, :note, :date_expired, :status_id,
     clearance_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    clearence_type
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Clearance ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Clearance type: </b> #{clearence_type}", :inline_format =>  true
    pdf.text "<b>Clearance Status: </b> #{clearence_status}", :inline_format =>  true
    pdf.text "<b>Date received: </b> #{date_received}", :inline_format =>  true
    pdf.text "<b>Date expired: </b> #{date_expired}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Clearance ##{id} </h2>"
    output<< "<b>Clearance type: </b> #{clearence_type}<br/>"
    output<< "<b>Clearance Status: </b> #{clearence_status}<br/>"
    output<< "<b>Date received: </b> #{date_received}<br/>"
    output<< "<b>Date expired: </b> #{date_expired}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
