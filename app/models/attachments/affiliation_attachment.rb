class AffiliationAttachment < Attachment
  belongs_to :owner, class_name: 'Affiliation'
end