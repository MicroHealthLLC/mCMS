class OtherHistory < ApplicationRecord
  def self.safe_attributes
[:user_id, :icdcm_code_id, :date_identified, :date_resolved, :other_history_status_id, :other_history_type_id, :description]
  end
end
