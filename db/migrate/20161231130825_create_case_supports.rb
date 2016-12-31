class CreateCaseSupports < ActiveRecord::Migration[5.0]
  def change
    create_table :case_supports do |t|
      t.integer :user_id
      t.integer :case_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :case_support_type_id
      t.text :note

      t.timestamps
    end
  end
end
