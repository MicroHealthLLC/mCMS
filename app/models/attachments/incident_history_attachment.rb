class IncidentHistoryAttachment < Attachment
  belongs_to :owner, class_name: 'IncidentHistory'
end