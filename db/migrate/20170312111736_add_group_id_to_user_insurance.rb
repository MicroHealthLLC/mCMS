class AddGroupIdToUserInsurance < ActiveRecord::Migration[5.0]
  def change
    add_column :user_insurances, :group_id, :text
  end
end
