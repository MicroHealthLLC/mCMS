class EnvironmentRisk < ApplicationRecord
  def self.safe_attributes
[:user_id, :icdcm_code_id, :date_started, :date_ended, :environment_status_id, :environment_type_id, :description]
  end
end
