class ClientOrganization < ApplicationRecord
  belongs_to :organization, optional: true
  def to_s
     name or organization
  end
end
