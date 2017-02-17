class CreateEnvironmentRisks < ActiveRecord::Migration[5.0]
  def change
    create_table :environment_risks do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.date :date_started
      t.date :date_ended
      t.integer :environment_status_id
      t.integer :environment_type_id
      t.text :description

      t.timestamps
    end
    add_index :environment_risks, :user_id
  end
end
