class AddInsitutionToEducation < ActiveRecord::Migration[5.0]
  def change
    add_column :educations, :institution, :string
    add_column :educations, :location_lat, :float
    add_column :educations, :location_long, :float
  end
end
