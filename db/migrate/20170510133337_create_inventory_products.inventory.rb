# This migration comes from inventory (originally 20170510133231)
class CreateInventoryProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_products, force: true do |t|
      t.string :name
      t.text :description
      t.integer :product_category_id
      t.integer :product_type_id
      t.string :manufacturer
      t.string :model
      t.string :serial
      t.float :unit_cost
      t.string :product_location
      t.integer :product_status_id

      t.timestamps
    end
    EnabledModule.create(name: 'inventory/products')
  end
end
