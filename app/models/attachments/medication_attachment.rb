class MedicationAttachment < Attachment
  belongs_to :owner, class_name: 'Medication'
end