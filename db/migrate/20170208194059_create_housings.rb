class CreateHousings < ActiveRecord::Migration[5.0]
  def change
    create_table :housings do |t|
      t.integer :user_id
      t.string :title
      t.integer :housing_type_id
      t.integer :cohabitation_type_id
      t.integer :housing_status_id
      t.text :description
      t.integer :primary_address_id
      t.string :estimated_monthly_payment
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
    add_index :housings, :user_id
    EnabledModule.where(name: 'housings').first_or_create
  end
end
