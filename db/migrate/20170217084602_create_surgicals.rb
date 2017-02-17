class CreateSurgicals < ActiveRecord::Migration[5.0]
  def change
    create_table :surgicals do |t|
      t.integer :surgical_type_id
      t.integer :user_id
      t.string :medical_facility
      t.date :surgery_date
      t.integer :surgery_status_id
      t.integer :surgery_type_id
      t.text :description

      t.timestamps
    end
    add_index :surgicals, :user_id
  end
end
