class CreateServiceHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :service_histories do |t|
      t.integer :user_id
      t.integer :rank_id
      t.integer :service_type_id
      t.integer :service_status_id
      t.integer :component_id
      t.integer :discharge_type_id
      t.date :date_entered
      t.date :end_active_obliged_service
      t.date :demobilization
      t.date :separation
      t.date :temporary_disability_retirement_list

      t.timestamps
    end
    add_index :service_histories, :user_id
  end
end
