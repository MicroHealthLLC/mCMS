class AddModifierToAppointmentProcedure < ActiveRecord::Migration[5.0]
  def change
    add_column :appointment_procedures, :modifier, :string
  end
end
