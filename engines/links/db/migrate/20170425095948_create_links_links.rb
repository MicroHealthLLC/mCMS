class CreateLinksLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links_links do |t|
      t.string :title
      t.string :url
      t.string :hostname
      t.integer :user_id

      t.timestamps
    end
    add_index :links_links, :user_id
  end
end
