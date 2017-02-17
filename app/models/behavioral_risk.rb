class BehavioralRisk < ApplicationRecord
  def self.safe_attributes
    [:user_id, :icdcm_code_id, :date_started, :date_ended,
     :behavioral_risk_status_id, :behavioral_risk_type_id, :description]
  end
end
