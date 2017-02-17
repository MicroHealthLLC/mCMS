class Surgical < ApplicationRecord
  def self.safe_attributes
[:surgical_type_id, :user_id, :medical_facility, :surgery_status_id, :surgery_type_id, :description]
  end
end
