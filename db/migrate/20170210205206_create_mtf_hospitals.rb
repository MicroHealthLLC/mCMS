class CreateMtfHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :mtf_hospitals do |t|
      t.string :mtf_hospital
      t.integer :user_id
      t.integer :incident_enum_id
      t.integer :incident_type_id
      t.integer :incident_category_id
      t.date :date_of_incident
      t.date :date_diagnosed
      t.string :incident_location_address
      t.string :incident_location_city
      t.integer :state_id
      t.integer :country_id
      t.integer :operation_id
      t.integer :verified_personnel_casualty_reporting_system_id
      t.integer :line_of_duty_investigation_id
      t.string :cause_of_injury
      t.text :injury_description
      t.string :pending_operation_procedure

      t.timestamps
    end
    add_index :mtf_hospitals, :user_id
    modules = ['service_histories', 'deployment_histories',
                'units', 'awards',
                'incident_histories', 'mtf_hospitals']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
  end
end
