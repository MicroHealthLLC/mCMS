class CreateDeploymentHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :deployment_histories do |t|
      t.integer :user_id
      t.integer :deployment_operation_id
      t.string :location
      t.string :city
      t.integer :state_id
      t.integer :country_id
      t.date :date_start
      t.date :date_end
      t.text :note

      t.timestamps
    end
    add_index :deployment_histories, :user_id
  end
end
