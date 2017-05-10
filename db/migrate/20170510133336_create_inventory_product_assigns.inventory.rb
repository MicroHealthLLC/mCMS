# This migration comes from inventory (originally 20170510133224)
class CreateInventoryProductAssigns < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_product_assigns do |t|
      t.integer :product_id
      t.integer :user_id
      t.date :date
      t.integer :assignment_status_id

      t.timestamps
    end
    add_index :inventory_product_assigns, :product_id
    add_index :inventory_product_assigns, :user_id
    EnabledModule.create(name: 'inventory/product_assigns')
  end
end
