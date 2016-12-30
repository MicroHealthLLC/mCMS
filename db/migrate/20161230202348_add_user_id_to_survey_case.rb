class AddUserIdToSurveyCase < ActiveRecord::Migration[5.0]
  def self.up
    add_column :survey_cases, :user_id, :integer
    SurveyCase.all.each do |survey_case|
      survey_case.user_id = survey_case.case.try(:user_id)
      survey_case.save
    end
  end
  def self.down
    remove_column :survey_cases, :user_id
  end
end
