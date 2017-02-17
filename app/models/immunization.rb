class Immunization < ApplicationRecord
  def self.safe_attributes
[:user_id, :medication, :total_number_of_doses, :doses_given, :next_date_due, :date_immunized, :manufacturer, :lot_number, :expiration_date, :immnunization_status_id, :description]
  end
end
