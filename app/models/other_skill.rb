class OtherSkill < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :other_skill_status, foreign_key: :status_id
  belongs_to :other_skill_type, foreign_key: :skill_type_id

  has_many :skill_attachments, foreign_key: :owner_id, dependent: :destroy
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

  def visible?
    User.current == user or User.current.allowed_to?(:edit_other_skills) or User.current.allowed_to?(:manage_other_skills)
  end

  def self.safe_attributes
    [:user_id, :name, :date_received, :is_private, :skill_type_id,
     :private_author_id, :date_expired, :note, :status_id,
     skill_attachments_attributes: [Attachment.safe_attributes]]
  end

  def self.enumeration_columns
    [
        ["#{OtherSkillStatus}", 'status_id'],
        ["#{OtherSkillType}", 'skill_type_id']
    ]
  end

  def skill_status
    if status_id
      other_skill_status
    else
      OtherSkillStatus.default
    end
  end
  alias status skill_status

   def skill_type
    if skill_type_id
      other_skill_type
    else
      OtherSkillType.default
    end
  end

  def to_s
    name
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Skill ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" SKILL "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Skill: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Skill Status: ", " #{skill_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Skill Type: ", " #{skill_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date received: ", " #{date_received}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date expired: ", " #{date_expired}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Skill ##{id} </h2>"
    output<< "<b>Skill: </b> #{name}<br/>"
    output<< "<b>Skill Status: </b> #{skill_status}<br/>"
    output<< "<b>Skill Type: </b> #{skill_type}<br/>"
    output<< "<b>Date received: </b> #{date_received}<br/>"
    output<< "<b>Date expired: </b> #{date_expired}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"
    output.html_safe
  end
end
