class JobDetail < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  # belongs_to :role

  validates_presence_of :user ,:organization_id

  def self.safe_attributes
    [:user_id, :organization_id, :note]
  end
end
