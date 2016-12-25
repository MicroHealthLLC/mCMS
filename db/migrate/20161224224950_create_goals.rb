class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.integer :priority_type_id
      t.integer :goal_status_id
      t.text :description
      t.date :date_start
      t.date :date_due
      t.date :date_complete
      t.integer :user_id
      t.integer :case_id

      t.timestamps
    end
  end
end
