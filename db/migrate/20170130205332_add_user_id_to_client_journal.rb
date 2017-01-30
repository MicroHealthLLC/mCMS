class AddUserIdToClientJournal < ActiveRecord::Migration[5.0]
  def change
    add_column :client_journals, :user_id, :integer
    add_index :client_journals, :user_id
    EnabledModule.create(name: 'client_journals')
  end
end
