class AddUserIdToFormular < ActiveRecord::Migration[5.0]
  def change
    add_column :formulars, :user_id, :integer
  end
end
