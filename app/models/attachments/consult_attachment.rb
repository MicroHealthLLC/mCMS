class ConsultAttachment < Attachment
  belongs_to :owner, class_name: 'Teleconsult'
end