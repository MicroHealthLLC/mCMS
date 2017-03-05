class CreatePlaceOfServices < ActiveRecord::Migration[5.0]
  def change
    create_table :place_of_services do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :place_of_services, :name
    add_index :place_of_services, :code
  end
end
