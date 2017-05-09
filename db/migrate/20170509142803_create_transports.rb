class CreateTransports < ActiveRecord::Migration[5.0]
  def change
    create_table :transports do |t|
      t.integer :user_id
      t.string :reason
      t.integer :transport_type_id
      t.text :description
      t.integer :transport_location_id
      t.integer :transport_status_id
      t.datetime :date_time

      t.timestamps
    end
    add_index :transports, :user_id
    EnabledModule.create(name: 'transports')
  end
end
