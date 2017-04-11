class SurveyUser < ApplicationRecord
  belongs_to :user, foreign_key: :assigned_to_id
  belongs_to :survey, foreign_key: :survey_id, class_name: 'survey_surveys'

  def self.safe_attributes
    [:assigned_to_id, :survey_id]
  end
end
