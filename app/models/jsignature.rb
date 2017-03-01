class Jsignature < ApplicationRecord
  belongs_to :user
  belongs_to :appointment, optional: true
  belongs_to :case, optional: true

  validates_presence_of :user_id, :person_name, :signature

  def to_s
    person_name
  end

  def self.safe_attributes
    [:user_id, :person_name, :appointment_id, :case_id, :signature]
  end
end
