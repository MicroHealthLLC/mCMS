class AddPlaceOfServiceIdToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :place_of_service_id, :integer
    add_index :appointments, :place_of_service_id
  end
end
