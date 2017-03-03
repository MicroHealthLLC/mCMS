class ClientOrganization < ApplicationRecord
  belongs_to :organization, optional: true
  def to_s
    name ? name : organization
  end
end
