class CreateFormulars < ActiveRecord::Migration[5.0]
  def change
    create_table :formulars do |t|
      t.string :name
      t.string :icon
      t.integer :placement
      t.text :form

      t.timestamps
    end
  end
end
