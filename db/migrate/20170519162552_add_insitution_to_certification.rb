class AddInsitutionToCertification < ActiveRecord::Migration[5.0]
  def change
    add_column :certifications, :certifying_organization, :string
    add_column :certifications, :location_lat, :float
    add_column :certifications, :location_long, :float
  end
end
