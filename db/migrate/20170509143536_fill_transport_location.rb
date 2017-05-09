class FillTransportLocation < ActiveRecord::Migration[5.0]
  def change
    ['Departing', 'Arriving', 'Return Departure', 'Return Arrival'].each do |name|
      TransportLocation.create(name: name)
    end

    add_column :transports, :case_id, :integer
    add_index :transports, :case_id

  end
end
