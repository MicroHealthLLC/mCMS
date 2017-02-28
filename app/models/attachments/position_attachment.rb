class PositionAttachment < Attachment
  belongs_to :owner, class_name: 'Position'
end