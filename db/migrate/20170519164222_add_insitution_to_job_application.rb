class AddInsitutionToJobApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :job_applications, :location_lat, :float
    add_column :job_applications, :location_long, :float
  end
end
