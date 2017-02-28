class OtherHistoryAttachment < Attachment
  belongs_to :owner, class_name: 'OtherHistory'
end