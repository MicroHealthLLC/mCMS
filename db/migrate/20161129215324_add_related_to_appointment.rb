class AddRelatedToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :related_to_id, :integer
  end
end
