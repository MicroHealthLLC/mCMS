class CreateFormResults < ActiveRecord::Migration[5.0]
  def change
    create_table :form_results do |t|
      t.integer :user_id
      t.integer :formular_id
      t.string :type
      t.string :name
      t.string :value
      t.text :long_value

      t.timestamps
    end
    add_index :form_results, :user_id
    add_index :form_results, :formular_id
  end
end
