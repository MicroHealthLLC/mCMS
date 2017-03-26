class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :comment_id
      t.timestamps null: false
    end
    add_index :points, :user_id
    add_index :points, :link_id
    add_index :points, :comment_id
    EnabledModule.where(name: 'rordit/links').first_or_create
  end
end
