class AddLocationToAffiliation < ActiveRecord::Migration[5.0]
  def change
    add_column :affiliations, :location, :string
    add_column :affiliations, :location_lat, :float
    add_column :affiliations, :location_long, :float
  end
end
