class RenamePostToNews < ActiveRecord::Migration[5.0]
  def change
    rename_table :posts, :news
  end
end
