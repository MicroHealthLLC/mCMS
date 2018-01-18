class AddEmplyerToJobApp < ActiveRecord::Migration[5.0]
  def change
    add_column :job_apps, :employer, :string
    add_column :job_apps, :location_lat, :float
    add_column :job_apps, :location_long, :float
    add_column :job_apps, :date_applied, :date
  end
end
