class AddPrivateAuthorSystem < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :private_author_id, :integer
    add_column :notes, :private_author_id, :integer
    add_column :cases, :private_author_id, :integer
    add_column :other_skills, :private_author_id, :integer
    add_column :tasks, :private_author_id, :integer
  end
end
