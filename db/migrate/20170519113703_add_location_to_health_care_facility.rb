class AddLocationToHealthCareFacility < ActiveRecord::Migration[5.0]
  def change
    add_column :health_care_facilities, :location_lat, :float
    add_column :health_care_facilities, :location_long, :float
  end
end
