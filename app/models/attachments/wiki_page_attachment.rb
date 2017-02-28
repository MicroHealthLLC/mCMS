class WikiPageAttachment < Attachment
  belongs_to :owner, class_name: 'WikiPage'
end