class CreateIcd10data < ActiveRecord::Migration[5.0]
  def change
    create_table :icd10data do |t|
      t.string :name
      t.integer :parent_id
      t.text :description
      t.text :childrens

      t.timestamps
    end
    add_index :icd10data, :name
    add_index :icd10data, :parent_id
  end
end
