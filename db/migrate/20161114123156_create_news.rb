class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :summary
      t.text :description
      t.integer :user_id
      t.integer :notes_count

      t.timestamps
    end
  end
end
