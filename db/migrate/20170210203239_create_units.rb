class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.integer :user_id
      t.integer :unit_enum_id
      t.integer :unit_type_id
      t.integer :installation_name_id
      t.date :date_start
      t.date :date_end
      t.text :note

      t.timestamps
    end
    add_index :units, :user_id
  end
end
