class CreateAppointmentProcedures < ActiveRecord::Migration[5.0]
  def self.up
    create_table :appointment_procedures do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.integer :procedure_id
      t.text :note
      t.date :date_recorded

      t.timestamps
    end
      AppointmentCapture.all.each do |capture|
        d = AppointmentProcedure.new(capture.attributes.slice('user_id', 'appointment_id', 'procedure_id', 'note',
                                                                'date_recorded'))
        d.save
      end
      remove_column :appointment_captures, :procedure_id
    end

    def self.down
      add_column  :appointment_captures, :procedure_id, :integer
      AppointmentProcedure.all.each do |capture|
        c = AppointmentCapture.new(capture.attributes.slice('user_id', 'appointment_id', 'procedure_id', 'note',
                                                            'date_recorded'))
        c.save
      end
      drop_table :appointment_procedures
    end
end
