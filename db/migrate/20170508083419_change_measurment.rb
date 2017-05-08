class ChangeMeasurment < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :measurement_name_id, :integer
  end
end
