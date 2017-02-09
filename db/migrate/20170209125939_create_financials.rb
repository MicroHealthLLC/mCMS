class CreateFinancials < ActiveRecord::Migration[5.0]
  def change
    create_table :financials do |t|
      t.string :title
      t.integer :user_id
      t.integer :financial_type_id
      t.integer :financial_status_id
      t.integer :financial_state_id
      t.text :description
      t.string :estimated_amount
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
    add_index :financials, :user_id
  end
end
