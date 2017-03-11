class AddAssociatedToBilling < ActiveRecord::Migration[5.0]
  def change
    add_column :billings, :associated_icd, :string
    add_column :billings, :associated_hcpc, :string
  end
end
