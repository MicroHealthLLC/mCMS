class CreateMeasurementRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :measurement_records do |t|
      t.string :measurement
      t.integer :component_id
      t.string :measured_by
      t.datetime :date_time
      t.integer :recorded_by_id
      t.integer :user_id
      t.string :device_id
      t.integer :age
      t.float :height
      t.float :weight
      t.string :gender
      t.integer :measure
      t.string :flag
      t.integer :measurement_status_id
      t.integer :case_id
      t.integer :plan_id

      t.timestamps
    end
    add_index :measurement_records, :user_id
    add_index :measurement_records, :case_id
    add_index :measurement_records, :plan_id

    EnabledModule.create(name: 'measurement_records')
  end
end
