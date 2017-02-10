class CreateAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :awards do |t|
      t.integer :user_id
      t.integer :award_type_id
      t.integer :award_enum_id
      t.date :award_date
      t.text :note

      t.timestamps
    end
    add_index :awards, :user_id
  end
end
