class CreateHealthCareFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :health_care_facilities do |t|
      t.integer :user_id
      t.string :name
      t.integer :health_care_facility_type_id
      t.integer :health_care_facility_status_id
      t.text :health_care_facility_contact
      t.date :date_started
      t.date :date_end
      t.text :description

      t.timestamps
    end
    add_index :health_care_facilities, :user_id
    EnabledModule.where(name: 'health_care_facilities').first_or_create
  end
end
