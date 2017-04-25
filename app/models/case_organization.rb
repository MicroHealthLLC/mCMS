class CaseOrganization < ApplicationRecord
  belongs_to :organization
  belongs_to :case

  # belongs_to :association

  def association_type
    @association ||= (AssociationType.find_by(association_id) || AssociationType.default)
  end

  def self.safe_attributes
    [:case_id, :organization_id, :association_id]
  end

  def to_s
    id
  end

end
