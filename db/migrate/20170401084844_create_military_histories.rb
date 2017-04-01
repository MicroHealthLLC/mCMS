class CreateMilitaryHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :military_histories do |t|
      t.integer :user_id
      t.string :text
      t.integer :service_type_id
      t.integer :service_status_id
      t.date :date_started
      t.date :date_ended
      t.text :note
      t.integer :updated_by_id
      t.integer :created_by_id

      t.timestamps
    end
    add_index :military_histories, :user_id
    EnabledModule.where(name: 'military_histories').create
  end
end
