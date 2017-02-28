class InjuryAttachment < Attachment
  belongs_to :owner, class_name: 'Injury'
end