class CreateProblemLists < ActiveRecord::Migration[5.0]
  def change
    create_table :problem_lists do |t|
      t.integer :icdcm_code_id
      t.integer :user_id
      t.datetime :date_onset
      t.datetime :date_resolved
      t.integer :problem_status_id
      t.integer :problem_type_id
      t.text :description

      t.timestamps
    end
    add_index :problem_lists, :user_id
  end
end
