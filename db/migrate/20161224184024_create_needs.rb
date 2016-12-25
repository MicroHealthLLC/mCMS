class CreateNeeds < ActiveRecord::Migration[5.0]
  def change
    create_table :needs do |t|
      t.integer :need_enum_id
      t.integer :priority_type_id
      t.integer :need_status_id
      t.text :description
      t.date :date_due
      t.date :date_completed
      t.date :date_identified
      t.integer :user_id
      t.integer :case_id

      t.timestamps
    end
  end
end
