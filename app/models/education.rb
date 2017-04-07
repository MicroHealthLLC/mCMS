class Education < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :education_type
  belongs_to :education_status, :foreign_key => :status_id

  has_many :education_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :education_attachments, reject_if: :all_blank, allow_destroy: true

  after_save :send_notification
  def send_notification
    UserMailer.education_notification(self).deliver_later
  end

  def visible?
    User.current == user or User.current.allowed_to?(:edit_educations) or User.current.allowed_to?(:manage_educations)
  end

  def self.enumeration_columns
    [
        ["#{EducationType}", 'education_type_id'],
        ["#{EducationStatus}", 'status_id']
    ]
  end

  def education_type
    if education_type_id
      super
    else
      EducationType.default
    end
  end

  def education_status
    if status_id
      super
    else
      EducationStatus.default
    end
  end
  alias status education_status

  def self.safe_attributes
    [:user_id, :education_type_id, :date_recieved,
     :date_expired, :note, :status_id,
     education_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    education_type
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Education ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Education "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Education Type: ", " #{education_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Education Status: ", " #{education_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date received: ", " #{date_recieved}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date expired: ", " #{date_expired}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def for_mail
    output = ""
    output<< "<h2>Education ##{id} </h2>"
    output<<"<b>Education Type: </b> #{education_type}<br/>"
    output<<"<b>Education Status: </b> #{education_status}<br/>"
    output<<"<b>Date received: </b> #{date_recieved}<br/>"
    output<<"<b>Date expired: </b> #{date_expired}<br/>"
    output<<"<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
