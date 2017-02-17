class CreateSocioeconomics < ActiveRecord::Migration[5.0]
  def change
    create_table :socioeconomics do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.date :date_identified
      t.date :date_resolved
      t.integer :socioeconomic_status_id
      t.integer :socioeconomic_type_id
      t.text :description

      t.timestamps
    end
    add_index :socioeconomics, :user_id
  end
end
