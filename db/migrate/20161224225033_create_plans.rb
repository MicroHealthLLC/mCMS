class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :priority_type_id
      t.integer :plan_status_id
      t.text :description
      t.date :date_start
      t.date :date_due
      t.date :date_completed
      t.integer :user_id
      t.integer :case_id

      t.timestamps
    end
  end
end
