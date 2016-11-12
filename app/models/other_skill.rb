class OtherSkill < ApplicationRecord
  belongs_to :user

  has_many :skill_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :skill_attachments, reject_if: :all_blank, allow_destroy: true
  scope :not_private, -> {where(is_private: false)}

  validates_presence_of :name
  before_create :check_private_author
  default_scope -> {where(is_private: false).or(where(private_author_id: User.current.id)) }

  def check_private_author
    if self.is_private
      self.private_author_id = User.current.id
    end
  end

  after_save :send_notification
  def send_notification
    UserMailer.skill_notification(self).deliver_now
  end

  def visible?
    User.current == user or User.current.allowed_to?(:edit_other_skills) or User.current.allowed_to?(:manage_other_skills)
  end

  def self.safe_attributes
    [:user_id, :name, :date_received, :is_private, :private_author_id, :date_expired, :note, skill_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Skill ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Skill: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Date received: </b> #{date_received}", :inline_format =>  true
    pdf.text "<b>Date expired: </b> #{date_expired}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Skill ##{id} </h2>"
    output<< "<b>Skill: </b> #{name}<br/>"
    output<< "<b>Date received: </b> #{date_received}<br/>"
    output<< "<b>Date expired: </b> #{date_expired}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"
    output.html_safe
  end
end
