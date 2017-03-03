class CreateAppointmentLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :appointment_links do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.string :linkable_type
      t.integer :linkable_id

      t.timestamps
    end
    add_index :appointment_links, :user_id
    add_index :appointment_links, :appointment_id
    add_index :appointment_links, :linkable_type
    add_index :appointment_links, :linkable_id
  end
end
