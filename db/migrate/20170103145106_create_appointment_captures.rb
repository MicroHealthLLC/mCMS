class CreateAppointmentCaptures < ActiveRecord::Migration[5.0]
  def change
    create_table :appointment_captures do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.integer :assessment_id
      t.integer :disposition_id
      t.integer :procedure_id
      t.text :note

      t.timestamps
    end
  end
end
