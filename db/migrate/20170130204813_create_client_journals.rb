class CreateClientJournals < ActiveRecord::Migration[5.0]
  def change
    create_table :client_journals do |t|
      t.string :title
      t.integer :client_journal_type_id
      t.datetime :date
      t.text :note

      t.timestamps
    end

  end
end
