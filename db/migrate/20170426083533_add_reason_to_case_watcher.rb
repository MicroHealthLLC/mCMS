class AddReasonToCaseWatcher < ActiveRecord::Migration[5.0]
  def change
    add_column :case_watchers, :reason, :text
  end
end
