class ChangeActionDates < ActiveRecord::Migration[5.0]
  def self.up
    change_column :tasks, :date_start, :datetime
    change_column :tasks, :date_completed, :datetime
  end

  def self.down
    change_column :tasks, :date_start, :date
    change_column :tasks, :date_completed, :date
  end
end
