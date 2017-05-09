class TransportAttachment < Attachment
  belongs_to :owner, class_name: 'Transport'
end