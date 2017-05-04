class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.string :name
      t.string :component
      t.string :order
      t.integer :lower_age, default: 0
      t.integer :upper_age, default: 0
      t.float :lower_height, default: 0
      t.float :upper_height, default: 0
      t.float :lower_weight, default: 0
      t.float :upper_weight, default: 0
      t.string :gender
      t.string :measured_by
      t.integer :lower_measure, default: 0
      t.integer :higher_measure, default: 0

      t.timestamps
    end
  end
end
