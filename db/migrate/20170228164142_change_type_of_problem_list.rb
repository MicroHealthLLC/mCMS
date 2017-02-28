class ChangeTypeOfProblemList < ActiveRecord::Migration[5.0]
  def self.up
    change_column :problem_lists, :date_onset, :date
    change_column :problem_lists, :date_resolved, :date
  end
  def self.down
    change_column :problem_lists, :date_onset, :datetime
    change_column :problem_lists, :date_resolved, :datetime
  end
end
