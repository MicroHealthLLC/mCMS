class CreateFormDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :form_details do |t|
      t.integer :user_id
      t.integer :formular_id

      t.timestamps
    end
    add_index :form_details, :user_id
    add_index :form_details, :formular_id
  end
end
