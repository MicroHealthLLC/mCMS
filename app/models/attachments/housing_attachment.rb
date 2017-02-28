class HousingAttachment < Attachment
  belongs_to :owner, class_name: 'Housing'
end