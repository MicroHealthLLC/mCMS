class CreateStickyNoteStickyNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :sticky_notes_sticky_notes do |t|
      t.integer :user_id
      t.text :todos

      t.timestamps
    end
    add_index :sticky_notes_sticky_notes, :user_id

    modules = ['sticky_notes']
    modules.each do |em|
      EnabledModule.where(name: em).first_or_create
    end
  end
end
