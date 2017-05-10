class CreateChangeProductLocations < ActiveRecord::Migration[5.0]
  def self.up
    Inventory::Product.update_all({product_location: nil})
   change_column :inventory_products, :product_location, :integer
   rename_column :inventory_products, :product_location, :product_location_id
  end

  def self.down
    change_column :inventory_products, :product_location_id, :string
    rename_column :inventory_products, :product_location_id, :product_location
  end
end
