class HealthCareFacility < ApplicationRecord
  belongs_to :user

  belongs_to :health_care_facility_status, :optional=> true
  belongs_to :health_care_facility_type, :optional=> true

  validates_presence_of :name, :user_id

  has_many :health_care_facility_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :health_care_facility_attachments, reject_if: :all_blank, allow_destroy: true

  def self.enumeration_columns
    [
        ["#{HealthCareFacilityStatus}", 'health_care_facility_status_id'],
        ["#{HealthCareFacilityType}", 'health_care_facility_type_id']
    ]
  end

  def health_care_facility_status
    if health_care_facility_status_id
      super
    else
      HealthCareFacilityStatus.default
    end
  end

  def health_care_facility_type
    if health_care_facility_type_id
      super
    else
      HealthCareFacilityType.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [
        :user_id, :name, :health_care_facility_type_id,
        :health_care_facility_status_id,
        :health_care_facility_contact, :date_started,
        :date_end, :description,
        :health_care_facility_attachments_attributes=> [Attachment.safe_attributes]
    ]
  end
end
