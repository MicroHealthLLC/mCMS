class AddLocationToEnrollment < ActiveRecord::Migration[5.0]
  def change
    add_column :enrollments, :enrollment_location, :string
    add_column :enrollments, :enrollment_location_lat, :float
    add_column :enrollments, :enrollment_location_long, :float
  end
end
