class Medication < ApplicationRecord
  def self.safe_attributes
[:user_id, :medication, :dose, :description, :date_prescripted, :date_expired, :total_refills, :refills_left, :medication_status_id, :medication_description]
  end
end
