class CreateOccupations < ActiveRecord::Migration[5.0]
  def change
    create_table :occupations do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :occupations, :name
    add_index :occupations, :code
  end
end
