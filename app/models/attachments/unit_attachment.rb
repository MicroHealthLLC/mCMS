class UnitAttachment < Attachment
  belongs_to :owner, class_name: 'Unit'
end