class HealthCareFacilityAttachment < Attachment
  belongs_to :owner, class_name: 'HealthCareFacility'
end