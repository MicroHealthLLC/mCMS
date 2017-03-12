class CreateRadiologicExaminations < ActiveRecord::Migration[5.0]
  def change
    create_table :radiologic_examinations do |t|
      t.integer :user_id
      t.string :name
      t.string :facility
      t.date :date
      t.text :result
      t.integer :radiologic_result_status_id

      t.timestamps
    end
    add_index :radiologic_examinations, :user_id
  end
end
