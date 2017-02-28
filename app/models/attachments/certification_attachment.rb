class CertificationAttachment < Attachment
  belongs_to :owner, class_name: 'Certification'
end