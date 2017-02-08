class CreateDailyLivings < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_livings do |t|
      t.string :title
      t.integer :user_id
      t.integer :daily_living_type_id
      t.integer :daily_living_status_id
      t.text :description
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
    add_index :daily_livings, :user_id
    EnabledModule.where(name: 'daily_livings').first_or_create
  end
end
