class CreateNoteTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :note_templates do |t|
      t.string :title
      t.text :note

      t.timestamps
    end
  end
end
