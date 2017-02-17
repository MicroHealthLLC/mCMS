class CreateOtherHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :other_histories do |t|
      t.integer :user_id
      t.integer :icdcm_code_id
      t.date :date_identified
      t.date :date_resolved
      t.integer :other_history_status_id
      t.integer :other_history_type_id
      t.text :description

      t.timestamps
    end
    add_index :other_histories, :user_id
  end
end
