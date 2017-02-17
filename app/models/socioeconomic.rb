class Socioeconomic < ApplicationRecord
  def self.safe_attributes
[:user_id, :icdcm_code_id, :date_identified, :date_resolved, :socioeconomic_status_id, :socioeconomic_type_id, :description]
  end
end
