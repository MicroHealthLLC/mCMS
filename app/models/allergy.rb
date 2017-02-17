class Allergy < ApplicationRecord


  def self.safe_attributes
    [
        :user_id, :allergy_type_id, :medication, :allergy_date, :allergy_status_id, :description
    ]
  end
end
