class CaseSupportAttachment < Attachment
  belongs_to :owner, class_name: 'CaseSupport'
end