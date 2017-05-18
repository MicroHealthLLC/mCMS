class AddLocationToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :location_lat, :float
    add_column :addresses, :location_long, :float
  end
end
