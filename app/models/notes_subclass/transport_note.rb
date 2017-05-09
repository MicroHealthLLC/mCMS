class TransportNote < Note
  belongs_to :transport, foreign_key: :owner_id, class_name: 'Transport'

  def object
    transport
  end

end
