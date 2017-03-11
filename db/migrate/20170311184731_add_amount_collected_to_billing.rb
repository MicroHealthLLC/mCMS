class AddAmountCollectedToBilling < ActiveRecord::Migration[5.0]
  def change
    add_column :billings, :amount_collected, :float
    change_column :billings, :resubmission_code, :text
    change_column :billings, :original_reference_number, :text
    change_column :billings, :prior_authorization_number, :text
  end
end
