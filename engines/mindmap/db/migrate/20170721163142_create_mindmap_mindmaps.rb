class CreateMindmapMindmaps < ActiveRecord::Migration[5.0]
  def change
    create_table :mindmap_mind_maps do |t|
      t.integer :user_id
      t.text :content

      t.timestamps
    end
    add_index :mindmap_mind_maps, :user_id
  end
end
