class CreateMedicals < ActiveRecord::Migration[5.0]
  def change
    create_table :medicals do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.string :medical_facility
      t.date :date_of_diagnosis
      t.integer :medical_history_status_id
      t.integer :medical_history_type_id
      t.text :description

      t.timestamps
    end
    add_index :medicals, :user_id
  end
end
