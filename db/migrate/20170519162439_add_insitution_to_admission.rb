class AddInsitutionToAdmission < ActiveRecord::Migration[5.0]
  def change
    add_column :admissions, :location_lat, :float
    add_column :admissions, :location_long, :float
  end
end
