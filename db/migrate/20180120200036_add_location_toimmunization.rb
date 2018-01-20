class AddLocationToimmunization < ActiveRecord::Migration[5.0]
  def change
    add_column :immunizations, :location_lat, :float
    add_column :immunizations, :location_long, :float
  end
end
