class AddLocationToInventoryProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :inventory_products, :location_lat, :float
    add_column :inventory_products, :location_long, :float
  end
end
