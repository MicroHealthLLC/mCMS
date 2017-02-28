class ImmunizationAttachment < Attachment
  belongs_to :owner, class_name: 'Immunization'
end