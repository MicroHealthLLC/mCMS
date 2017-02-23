class CreateJsignatures < ActiveRecord::Migration[5.0]
  def change
    create_table :jsignatures do |t|
      t.integer :user_id
      t.string :person_name
      t.integer :appointment_id
      t.text :signature

      t.timestamps
    end
    add_index :jsignatures, :user_id
    add_index :jsignatures, :appointment_id
  end
end
