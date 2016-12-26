class CreateCaseWatchers < ActiveRecord::Migration[5.0]
  def change
    create_table :case_watchers do |t|
      t.integer :user_id
      t.integer :case_id

      t.timestamps
    end
  end
end
