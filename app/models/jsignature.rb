class Jsignature < ApplicationRecord
  belongs_to :user
  belongs_to :appointment

  validates_presence_of :user_id, :appointment_id, :person_name, :signature

  def to_s
    person_name
  end

  def self.safe_attributes
    [:user_id, :person_name, :appointment_id, :signature]
  end
end
