class CreateRelatedClients < ActiveRecord::Migration[5.0]
  def change
    create_table :related_clients do |t|
      t.integer :user_id
      t.integer :related_client_id
      t.integer :relationship_id
      t.date :date_start
      t.date :date_end
      t.text :description

      t.timestamps
    end
    add_index :related_clients, :user_id
  end
end
