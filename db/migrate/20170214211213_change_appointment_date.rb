class ChangeAppointmentDate < ActiveRecord::Migration[5.0]
  def self.up
    add_column :appointments, :end_time, :datetime
    change_column :appointments, :date, :datetime
    Appointment.all.each do |a|
      a.date = "#{a.date.to_date} #{a.time}".to_time
      a.save
    end
  end

  def self.down

  end
end
