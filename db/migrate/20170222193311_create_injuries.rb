class CreateInjuries < ActiveRecord::Migration[5.0]
  def change
    create_table :injuries do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.integer :injury_type_id
      t.integer :injury_cause_id
      t.integer :injury_status_id
      t.string :employer
      t.date :date_of_injury
      t.date :date_resolved
      t.text :description

      t.timestamps
    end
    add_index :injuries, :user_id
  end
end
