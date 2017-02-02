class CreateTeleconsults < ActiveRecord::Migration[5.0]
  def change
    create_table :teleconsults do |t|
      t.integer :user_id
      t.integer :case_id
      t.integer :contact_method_id
      t.integer :contact_type_id
      t.integer :consult_status_id
      t.date :date
      t.string :time
      t.text :note

      t.timestamps
    end
    add_index :teleconsults, :user_id
    add_index :teleconsults, :case_id

    EnabledModule.create(name: 'teleconsults')
  end
end
