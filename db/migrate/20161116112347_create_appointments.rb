class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :title
      t.text :description
      t.integer :appointment_type_id
      t.date :date
      t.string :time
      t.integer :appointment_status_id
      t.integer :user_id
      t.integer :with_who_id
      t.string :with_who_type

      t.timestamps
    end

    modules = %w{appointments forum wiki posts}

    modules.each do |em|
      EnabledModule.create(name: em)
    end
  end
end
