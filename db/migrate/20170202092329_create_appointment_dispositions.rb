class CreateAppointmentDispositions < ActiveRecord::Migration[5.0]
  def self.up
    create_table :appointment_dispositions do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.integer :disposition_id
      t.text :note
      t.date :date_recorded

      t.timestamps
    end

    AppointmentCapture.all.each do |capture|
      d = AppointmentDisposition.new(capture.attributes.slice('user_id', 'appointment_id', 'disposition_id', 'note',
                                     'date_recorded'))
      d.save
    end
    remove_column :appointment_captures, :disposition_id
  end

  def self.down
    add_column  :appointment_captures, :disposition_id, :integer
    AppointmentDisposition.all.each do |capture|
      c = AppointmentCapture.new(capture.attributes.slice('user_id', 'appointment_id', 'disposition_id', 'note',
                                                              'date_recorded'))
      c.save
    end
    drop_table :appointment_dispositions
  end
end
