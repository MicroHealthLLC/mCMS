class AddAnonymeUserToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :anonyme_user, :boolean, default: false
  end
end
