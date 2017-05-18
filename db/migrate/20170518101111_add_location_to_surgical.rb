class AddLocationToSurgical < ActiveRecord::Migration[5.0]
  def change
    add_column :surgicals, :location_lat, :float
    add_column :surgicals, :location_long, :float
  end
end
