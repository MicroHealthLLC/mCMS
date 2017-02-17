class CreateAllergies < ActiveRecord::Migration[5.0]
  def change
    create_table :allergies do |t|
      t.integer :user_id
      t.integer :allergy_type_id
      t.string :medication
      t.date :allergy_date
      t.integer :allergy_status_id
      t.text :description

      t.timestamps
    end
    add_index :allergies, :user_id
  end
end
