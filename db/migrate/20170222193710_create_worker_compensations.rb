class CreateWorkerCompensations < ActiveRecord::Migration[5.0]
  def change
    create_table :worker_compensations do |t|
      t.integer :user_id
      t.integer :injury_id
      t.integer :compensation_type_id
      t.integer :compensation_status_id
      t.text :description
      t.date :date_of_compensation_start
      t.date :date_of_compensation_end

      t.timestamps
    end
    add_index :worker_compensations, :user_id
  end
end
