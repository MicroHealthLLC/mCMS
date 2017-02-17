class CreateBehaviolRisks < ActiveRecord::Migration[5.0]
  def change
    create_table :behaviol_risks do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.date :date_started
      t.date :date_ended
      t.integer :behavioral_risk_status_id
      t.integer :behavioral_risk_type_id
      t.text :description

      t.timestamps
    end
    add_index :behaviol_risks, :user_id
  end
end
