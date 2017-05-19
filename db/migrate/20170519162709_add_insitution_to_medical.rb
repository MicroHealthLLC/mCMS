class AddInsitutionToMedical < ActiveRecord::Migration[5.0]
  def change
    add_column :medicals, :location_lat, :float
    add_column :medicals, :location_long, :float
  end
end
