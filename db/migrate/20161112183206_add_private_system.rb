class AddPrivateSystem < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :is_private, :boolean, default: false
    add_column :notes, :is_private, :boolean, default: false
    add_column :cases, :is_private, :boolean, default: false
    add_column :other_skills, :is_private, :boolean, default: false
    add_column :tasks, :is_private, :boolean, default: false
  end
end
