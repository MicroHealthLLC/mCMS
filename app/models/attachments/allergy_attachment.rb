class AllergyAttachment < Attachment
  belongs_to :owner, class_name: 'Allergy'
end