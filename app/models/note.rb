class Note < ApplicationRecord
  belongs_to :user
  scope :not_private, -> {where(is_private: false)}
  default_scope -> {where(is_private: false).or(where(private_author_id: User.current.id)) }


  def self.safe_attributes
    [:user_id, :owner_id, :type, :note, :is_private, :private_author_id]
  end

  before_create :check_private_author

  def check_private_author
    if self.is_private
      self.private_author_id = User.current.id
    end
  end

  def object

  end

  def for_type
    case type
      when 'TaskNote' then I18n.t('task')
      when 'SurveyNote' then I18n.t('survey')
      when 'PostNote' then I18n.t('news')
      when 'CaseNote' then I18n.t('case')
      when 'ChecklistNote' then I18n.t('checklist')
      when 'AppointmentNote' then I18n.t('appointments')
      when 'NeedNote' then I18n.t('need')
      when 'GoalNote' then I18n.t('goal')
      when 'PlanNote' then I18n.t('plan')
    end
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Note ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Created at: </b> #{created_at.to_date}", :inline_format =>  true
    pdf.text "<b>Belongs to: </b> #{object}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true

  end

end

require_dependency 'task_note'
require_dependency 'checklist_note'
require_dependency 'post_note'
require_dependency 'case_note'
require_dependency 'survey_note'
require_dependency 'appointment_note'
require_dependency 'goal_note'
require_dependency 'plan_note'
require_dependency 'need_note'
