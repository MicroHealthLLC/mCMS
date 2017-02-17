class FamilyHistory < ApplicationRecord
  def self.safe_attributes
[:user_id, :icdcm_code_id, :date_identified, :family_status_id, :family_type_id, :description]
  end
end
