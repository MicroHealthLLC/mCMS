class CreateJobApps < ActiveRecord::Migration[5.0]
  def change
    create_table :job_apps do |t|
      t.string :title
      t.integer :occupation_id
      t.text :description
      t.integer :app_state_id
      t.integer :user_id

      t.timestamps
    end
    add_index :job_apps, :app_state_id
    add_index :job_apps, :user_id
  end
end
