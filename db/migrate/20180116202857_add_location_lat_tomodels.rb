class AddLocationLatTomodels < ActiveRecord::Migration[5.0]
  def change
    add_column :housings, :location_lat, :float
    add_column :positions, :location_lat, :float
    add_column :injuries, :location_lat, :float
    add_column :enrollments, :location_lat, :float
    add_column :referrals, :location_lat, :float
    add_column :radiologic_examinations, :location_lat, :float
    add_column :laboratory_examinations, :location_lat, :float


   add_column :housings, :location_long, :float
    add_column :positions, :location_long, :float
    add_column :injuries, :location_long, :float
    add_column :enrollments, :location_long, :float
    add_column :referrals, :location_long, :float
    add_column :radiologic_examinations, :location_long, :float
    add_column :laboratory_examinations, :location_long, :float


  end
end
