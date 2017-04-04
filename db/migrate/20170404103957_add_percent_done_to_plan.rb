class AddPercentDoneToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :percent_done, :integer
    add_column :needs, :percent_done, :integer
    add_column :goals, :percent_done, :integer
  end
end
