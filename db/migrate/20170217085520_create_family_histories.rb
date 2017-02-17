class CreateFamilyHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :family_histories do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.date :date_identified
      t.integer :family_status_id
      t.integer :family_type_id
      t.text :description

      t.timestamps
    end
    add_index :family_histories, :user_id
  end
end
