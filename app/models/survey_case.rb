class SurveyCase < ApplicationRecord
  belongs_to :case, foreign_key: :assigned_to_id
  belongs_to :survey, class_name: 'Survey::Survey'

  def self.visible
    case_scope = Case.root
    case_scope = case_scope.where('assigned_to_id= :user OR user_id= :user', user: User.current.id )
    SurveyCase.where(assigned_to_id: case_scope.pluck(:id))
  end

  def self.for_survey(survey)
    where(survey_id: survey.id)
  end
end
