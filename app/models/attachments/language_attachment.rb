class LanguageAttachment < Attachment
  belongs_to :owner, class_name: 'Language'
end