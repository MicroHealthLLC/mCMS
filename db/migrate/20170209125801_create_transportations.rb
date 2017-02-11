class CreateTransportations < ActiveRecord::Migration[5.0]
  def change
    create_table :transportations do |t|
      t.integer :user_id
      t.string :title
      t.integer :transportation_mean_id
      t.integer :transportation_type_id
      t.integer :transportation_accessibility_id
      t.integer :transportation_status_id
      t.text :description
      t.string :estimated_monthly_cost
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
    add_index :transportations, :user_id
  end
end
