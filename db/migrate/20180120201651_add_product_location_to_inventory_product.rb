class AddProductLocationToInventoryProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :inventory_products, :product_location, :string
    add_column :inventory_products, :product_location_lat, :float
    add_column :inventory_products, :product_location_long, :float
  end
end
