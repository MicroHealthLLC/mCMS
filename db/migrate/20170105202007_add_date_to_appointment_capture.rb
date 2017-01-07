class AddDateToAppointmentCapture < ActiveRecord::Migration[5.0]
  def change
    add_column :appointment_captures, :date_recorded, :date
  end
end
