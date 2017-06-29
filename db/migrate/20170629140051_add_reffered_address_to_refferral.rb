class AddRefferedAddressToRefferral < ActiveRecord::Migration[5.0]
  def change
    add_column :referrals, :referred_to_address, :string
  end
end
