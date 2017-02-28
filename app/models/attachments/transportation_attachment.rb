class TransportationAttachment < Attachment
  belongs_to :owner, class_name: 'Transportation'
end