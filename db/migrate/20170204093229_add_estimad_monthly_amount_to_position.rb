class AddEstimadMonthlyAmountToPosition < ActiveRecord::Migration[5.0]
  def change
    add_column :positions, :estimated_monthly_amount, :string
  end
end
