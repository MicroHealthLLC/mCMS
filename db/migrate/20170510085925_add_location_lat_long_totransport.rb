class AddLocationLatLongTotransport < ActiveRecord::Migration[5.0]
  def change
    add_column :transports, :location_lat, :float
    add_column :transports, :location_long, :float
  end
end
