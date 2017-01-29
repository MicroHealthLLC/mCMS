class Language < ApplicationRecord
  belongs_to :user
  belongs_to :language_type
  belongs_to :language_status, foreign_key: :status_id
  belongs_to :proficiency_type, foreign_key: :proficiency_id

  has_many :language_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :language_attachments, reject_if: :all_blank, allow_destroy: true

  after_save :send_notification
  def send_notification
    UserMailer.language_notification(self).deliver_later
  end

  def language_type
    if language_type_id
      super
    else
      LanguageType.default
    end
  end

 def language_status
    if status_id
      super
    else
      LanguageStatus.default
    end
  end

  def proficiency_type
    if proficiency_id
      super
    else
      ProficiencyType.default
    end
  end

  def visible?
    User.current.permitted_users.include? user
  end

  def self.safe_attributes
    [:user_id, :note, :language_type_id, :proficiency_id, :status_id,
     language_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    language_type
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Language ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Language type: </b> #{language_type}", :inline_format =>  true
    pdf.text "<b>Language Status: </b> #{language_status}", :inline_format =>  true
    pdf.text "<b>Proficiency: </b> #{proficiency_type}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Language ##{id} </h2>"
    output<< "<b>Language type: </b> #{language_type}<br/>"
    output<< "<b>Language Status: </b> #{language_status}<br/>"
    output<< "<b>Proficiency: </b> #{proficiency_type}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
