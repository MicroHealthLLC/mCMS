class Medical < ApplicationRecord
  def self.safe_attributes
    [:user_id, :icdcm_code_id, :medical_facility, :date_of_diagnosis, :medical_history_status_id, :medical_history_type_id, :description]
  end
end
