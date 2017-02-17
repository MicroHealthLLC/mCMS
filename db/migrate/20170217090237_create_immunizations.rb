class CreateImmunizations < ActiveRecord::Migration[5.0]
  def change
    create_table :immunizations do |t|
      t.integer :user_id
      t.string :medication
      t.integer :total_number_of_doses
      t.integer :doses_given
      t.date :next_date_due
      t.date :date_immunized
      t.text :manufacturer
      t.text :lot_number
      t.date :expiration_date
      t.integer :immnunization_status_id
      t.text :description

      t.timestamps
    end
    add_index :immunizations, :user_id
  end
end
