class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :employer
      t.integer :application_stage_id
      t.integer :user_id
      t.integer :job_app_id
      t.integer :position_type_id
      t.date :date
      t.integer :application_status_id
      t.float :location_lat
      t.float :location_long

      t.timestamps
    end
    add_index :jobs, :application_stage_id
    add_index :jobs, :user_id
    add_index :jobs, :job_app_id
    add_index :jobs, :position_type_id
    add_index :jobs, :application_status_id
  end
end
