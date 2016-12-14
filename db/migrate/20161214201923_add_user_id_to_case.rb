class AddUserIdToCase < ActiveRecord::Migration[5.0]
  def change
    add_column :cases, :user_id, :integer
    Case.all.each do |c|
      c.user_id = c.assigned_to_id
      c.save
    end
  end
end
