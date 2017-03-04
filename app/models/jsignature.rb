class Jsignature < ApplicationRecord
  belongs_to :user
  belongs_to :signature_owner, polymorphic: true

  validates_presence_of :user_id, :person_name, :signature

  def to_s
    person_name
  end

  def self.safe_attributes
    [:user_id, :person_name, :signature_owner_type, :signature_owner_id, :signature]
  end
end
