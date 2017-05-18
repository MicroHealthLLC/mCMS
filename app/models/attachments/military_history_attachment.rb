class MilitaryHistoryAttachment < Attachment
  belongs_to :owner, class_name: 'MilitaryHistory'
end