class AwardAttachment < Attachment
  belongs_to :owner, class_name: 'Award'
end