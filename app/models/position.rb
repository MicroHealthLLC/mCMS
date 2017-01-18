class Position < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  belongs_to :pay_rate_type, optional: true, foreign_key: :pay_rate_id
  belongs_to :employment_type, optional: true
  belongs_to :location_type, optional: true


  has_many :position_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :position_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :organization_id, :user_id

  validates_presence_of :title
  after_save :send_notification

  def send_notification
    UserMailer.position_notification(self).deliver_later
  end

  def pay_rate_type
    if pay_rate_id
      super
    else
      PayRateType.default
    end
  end

  def employment_type
    if employment_type_id
      super
    else
      EmploymentType.default
    end
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
    [:user_id, :title, :position_description,
     :location_type_id, :special_requirement, :note,
     :date_start, :date_end, :organization_id, :salary, :pay_rate_id, :employment_type_id,
     position_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Position ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>title: </b> #{title}", :inline_format =>  true
    pdf.text "<b>Position description: </b> #{ActionView::Base.full_sanitizer.sanitize(position_description)}", :inline_format =>  true
    pdf.text "<b>Location: </b> #{location_type}", :inline_format =>  true
    pdf.text "<b>Special requirement: </b> #{special_requirement}", :inline_format =>  true
    pdf.text "<b>Date start: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>Date end: </b> #{date_end}", :inline_format =>  true
    pdf.text "<b>Employment type: </b> #{employment_type}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Position ##{id} </h2>"
    output<<"<b>title: </b> #{title}<br/>"
    output<<"<b>Position description: </b> #{position_description}<br/>"
    output<<"<b>Location: </b> #{location_type}<br/>"
    output<<"<b>Special requirement: </b> #{special_requirement}<br/>"
    output<<"<b>Date start: </b> #{date_start}<br/>"
    output<<"<b>Date end: </b> #{date_end}<br/>"
    # output<<"<b>Pay: </b> #{salary}<br/>"
    # output<<"<b>Pay rate: </b> #{pay_rate_type}<br/>"
    output<<"<b>Employment type: </b> #{employment_type}<br/>"
    output<<"<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
