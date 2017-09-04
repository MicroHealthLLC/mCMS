class AddAddressToHousing < ActiveRecord::Migration[5.0]
  def self.up
    add_column :housings, :address, :string
    Housing.all.each do |housing|
      housing.address = housing.primary_address.to_s
      housing.save
    end
  end

  def self.down
    remove_column  :housings, :address

  end
end
