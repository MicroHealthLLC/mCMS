class ChangeDateAction < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :date_due, :datetime
  end
end
