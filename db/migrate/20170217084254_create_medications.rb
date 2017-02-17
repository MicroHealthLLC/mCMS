class CreateMedications < ActiveRecord::Migration[5.0]
  def change
    create_table :medications do |t|
      t.integer :user_id
      t.string :medication
      t.string :dose
      t.text :description
      t.date :date_prescribed
      t.date :date_expired
      t.integer :total_refills
      t.integer :refills_left
      t.integer :medication_status_id
      t.text :medication_description

      t.timestamps
    end
    add_index :medications, :user_id
  end
end
